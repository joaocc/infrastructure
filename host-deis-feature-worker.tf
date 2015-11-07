resource "aws_autoscaling_group" "deis-feature-workers" {
  name = "Deis Feature Workers"

  # Network
  availability_zones = ["${aws_subnet.subnet.2.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.subnet.2.id}"]

  # Cluster Size
  max_size = 4
  min_size = 1
  desired_capacity = "${lookup(var.counts, "feature_workers")}"

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.deis-feature-worker.id}"

  # Tags
  tag {
    key = "Name"
    value = "Feature Worker"
    propagate_at_launch = true
  }

  tag {
    key = "Environment"
    value = "Feature"
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

resource "aws_launch_configuration" "deis-feature-worker" {

    # General Config
    image_id = "${lookup(var.amis, "coreos_766_5_0")}"
    instance_type = "${lookup(var.instance_types, "feature_worker")}"
    user_data = "${template_file.deis-feature-worker.rendered}"
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
