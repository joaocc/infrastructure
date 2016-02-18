resource "aws_autoscaling_group" "deis-services" {
  name = "Deis Services"

  # Network
  availability_zones = ["${aws_subnet.subnet.2.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.subnet.2.id}"]

  # Cluster Size
  max_size = 1
  min_size = 1
  desired_capacity = 1

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.deis-services.id}"

  # Tags
  tag {
    key = "Name"
    value = "Deis Services"
    propagate_at_launch = true
  }

  tag {
    key = "Function"
    value = "Deis"
    propagate_at_launch = true
  }

  tag {
    key = "Type"
    value = "Services"
    propagate_at_launch = true
  }

}

resource "aws_launch_configuration" "deis-services" {

    # General Config
    image_id = "${lookup(var.amis, "coreos_835_12_0")}"
    instance_type = "${lookup(var.instance_types, "deis-services")}"
    user_data = "${template_file.deis-services.rendered}"
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
      volume_size = 500
      volume_type = "gp2"
    }

    lifecycle { create_before_destroy = true }

}
