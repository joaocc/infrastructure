resource "aws_autoscaling_group" "deis-production-workers" {
  name = "Deis Production Workers"

  # Network
  availability_zones = ["${aws_subnet.subnet.*.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.subnet.*.id}"]

  # Cluster Size
  max_size = 12
  min_size = 3
  desired_capacity = "${lookup(var.counts, "production_workers")}"

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.deis-production-worker.id}"

  # Tags
  tag {
    key = "Name"
    value = "Production Worker"
    propagate_at_launch = true
  }

  tag {
    key = "Environment"
    value = "Production"
    propagate_at_launch = true
  }

  tag {
    key = "Function"
    value = "Deis"
    propagate_at_launch = true
  }

  tag {
    key = "Type"
    value = "Worker"
    propagate_at_launch = true
  }

}

resource "aws_launch_configuration" "deis-production-worker" {

    # General Config
    image_id = "${lookup(var.amis, "coreos_723_3_0")}"
    instance_type = "${lookup(var.instance_types, "production_worker")}"
    user_data = "${template_file.deis-production-worker.rendered}"
    key_name = "deis"

    # Networking
    security_groups = [
      "${aws_security_group.worker.id}",
      "${aws_security_group.internal-communication.id}"
    ]
    associate_public_ip_address = true

    # Storage
    root_block_device {
      volume_size = 50
      volume_type = "gp2"
    }

    ebs_block_device {
      device_name = "/dev/xvdf"
      volume_size = 100
      volume_type = "gp2"
    }

    lifecycle { create_before_destroy = true }

}
