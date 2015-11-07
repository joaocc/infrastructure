# Deis core instances
resource "aws_instance" "deis-core-etcd2" {
    count = "${lookup(var.counts, "core")}"
    ami = "${lookup(var.amis, "coreos_766_5_0")}" # This can NEVER change
    key_name = "deis"
    instance_type = "${lookup(var.instance_types, "core")}"
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index % lookup(var.counts, "subnets"))}"
    associate_public_ip_address = true
    security_groups = [
      "${aws_security_group.core.id}",
      "${aws_security_group.internal-communication.id}"
    ]
    user_data = "${template_file.deis-core.rendered}"
    tags {
        Name = "Deis Core Etcd2 ${count.index + 1}"
        Type = "Core"
        Function = "Deis"
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

resource "aws_eip" "deis-core-etcd2" {
    count = "${lookup(var.counts, "core")}"
    instance = "${element(aws_instance.deis-core-etcd2.*.id, count.index)}"
    vpc = true
}
