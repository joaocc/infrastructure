resource "aws_autoscaling_group" "deis-router" {
  name = "Routers"

  # Network
  availability_zones = ["${aws_subnet.subnet.*.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.subnet.*.id}"]
  load_balancers = [
    "${aws_elb.brandfolder-com.id}",
    "${aws_elb.brandfolder-ninja.id}"
  ]

  # Cluster Size
  max_size = 12
  min_size = 1
  desired_capacity = "${lookup(var.counts, "routers")}"

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.deis-router.id}"

  # Tags
  tag {
    key = "Name"
    value = "Router"
    propagate_at_launch = true
  }

  tag {
    key = "Function"
    value = "Deis"
    propagate_at_launch = true
  }

  tag {
    key = "Type"
    value = "Router"
    propagate_at_launch = true
  }

}

resource "aws_launch_configuration" "deis-router" {

    # General Config
    image_id = "${lookup(var.amis, "coreos_717_3_0")}"
    instance_type = "${lookup(var.instance_types, "router")}"
    user_data = "${template_file.deis-router.rendered}"
    key_name = "deis"

    # Networking
    security_groups = [
      "${aws_security_group.router.id}",
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
