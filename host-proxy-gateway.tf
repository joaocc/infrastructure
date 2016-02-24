# Bastion instance for remote ssh access
resource "aws_instance" "proxy-gateway" {
    ami = "${lookup(var.amis, "coreos_835_13_0")}"
    key_name = "deis"
    instance_type = "${lookup(var.instance_types, "proxy-gateway")}"
    subnet_id = "${aws_subnet.subnet.1.id}"
    associate_public_ip_address = true
    security_groups = [
      "${aws_security_group.internal-communication.id}",
      "${aws_security_group.postgres.id}"
    ]
    user_data = "${template_file.proxy-gateway.rendered}"

    tags {
        Name = "Proxy Gateway"
        Type = "Proxy Gateway"
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
