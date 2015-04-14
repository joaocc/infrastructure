resource "aws_autoscaling_group" "paas" {
  name = "PaaS"

  # Network
  availability_zones = ["${aws_subnet.az-us-east-1a.availability_zone}",
                        "${aws_subnet.az-us-east-1c.availability_zone}"]

  vpc_zone_identifier = ["${aws_subnet.az-us-east-1a.id}",
                        "${aws_subnet.az-us-east-1c.id}"]

  load_balancers = ["${aws_elb.paas.name}",
                    "${aws_elb.internal.name}",
                    "${aws_elb.www.name}"]

  # Cluster Size
  max_size = 12
  min_size = 3
  desired_capacity = "${var.cluster_size}"

  # General Configuration
  force_delete = true
  launch_configuration = "${aws_launch_configuration.paas-node.id}"

}

resource "aws_launch_configuration" "paas-node" {
    name = "PaaS-node"

    # General Config
    image_id = "${lookup(var.aws_coreos_amis, var.aws_region)}"
    instance_type = "${var.aws_instance_type}"
    user_data = "${file("conf/deis-node/user-data")}"
    key_name = "deis"

    # Networking
    security_groups = ["${aws_security_group.paas-private.id}"]
    associate_public_ip_address  = true

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

}
