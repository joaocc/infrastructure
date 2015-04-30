# Deis core instances
resource "aws_instance" "deis-core" {
    count = "${lookup(var.counts, "core")}"
    ami = "${lookup(var.amis, "coreos")}"
    key_name = "deis"
    instance_type = "${lookup(var.instance_types, "core")}"
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index % lookup(var.counts, "subnets"))}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.deis-private.id}"]
    user_data = "${replace(replace(replace(file("conf/deis-core/user-data"), "{{discovery_url}}", file("private/etcd/discovery-url")), "{{deis_version}}", "${var.deis_version}"), "{{tags}}", "${lookup(var.fleet_tags, "core")}")}"
    tags {
        Name = "Deis Core ${count.index + 1}"
        Type = "Core"
        Environment = "Deis"
    }

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

resource "aws_eip" "deis-core" {
    count = "${lookup(var.counts, "core")}"
    instance = "${element(aws_instance.deis-core.*.id, count.index)}"
    vpc = true
}
