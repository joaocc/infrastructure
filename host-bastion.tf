# Bastion instance for remote ssh access
resource "aws_instance" "bastion" {
    ami = "${lookup(var.amis, "coreos")}"
    key_name = "deis"
    instance_type = "${lookup(var.instance_types, "bastion")}"
    subnet_id = "${aws_subnet.subnet.1.id}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.bastion.id}"]
    user_data = "${template_file.bastion.rendered}"

    tags {
        Name = "Bastion (SSH Gateway)"
        Type = "Bastion"
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