resource "aws_autoscaling_group" "deis-production-workers" {
  name = "Deis Workers"

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

}

resource "aws_launch_configuration" "deis-production-worker" {
    name = "deis-worker"

    # General Config
    image_id = "${lookup(var.amis, "coreos")}"
    instance_type = "${lookup(var.instance_types, "production_worker")}"
    user_data = "${replace(replace(replace(file("conf/deis-worker/user-data"), "{{etcd_lb}}", "${aws_elb.etcd.dns_name}"), "{{deis_version}}", "${var.deis_version}"), "{{tags}}", "${lookup(var.fleet_tags, "production_worker")}")}"
    key_name = "deis"

    # Networking
    security_groups = ["${aws_security_group.deis-private.id}"]
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

}