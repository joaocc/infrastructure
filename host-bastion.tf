# Bastion instance for remote ssh access
resource "aws_instance" "bastion" {
    ami = "${lookup(var.aws_ubuntu_amis, var.aws_region)}"
    key_name = "deis"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.az-us-east-1a.id}"
    associate_public_ip_address = true
    security_groups = ["${aws_security_group.bastion.id}"]
    tags {
        Name = "bastion"
    }

    # Copy the .bash-profile
    provisioner "file" {
        source = "conf/bastion/.bash_profile"
        destination = "/home/ubuntu/.bash_profile"
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Make the .ssh directory
    provisioner "remote-exec" {
        inline = [
            "mkdir -p /home/ubuntu/.ssh"
        ]
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Copy the SSH Key
    provisioner "file" {
        source = "private/.ssh/"
        destination = "/home/ubuntu/.ssh"
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Copy the SSH config
    provisioner "file" {
        source = "conf/bastion/.ssh/"
        destination = "/home/ubuntu/.ssh"
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Set the permission on the ssh key
    provisioner "remote-exec" {
        inline = [
            "chmod 400 /home/ubuntu/.ssh/deis"
        ]
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Install fleetctl
    provisioner "remote-exec" {
        inline = [
            "mkdir -p $HOME/bin",
            "curl -L https://github.com/coreos/fleet/releases/download/v0.9.2/fleet-v0.9.2-linux-amd64.tar.gz | tar zxv",
            "cp fleet-v0.9.2-linux-amd64/fleetctl $HOME/bin",
        ]
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Install deisctl
    provisioner "remote-exec" {
        inline = [
            "mkdir -p $HOME/bin",
            "cd $HOME/bin",
            "curl -sSL http://deis.io/deisctl/install.sh | sh -s ${var.deis_version}"
        ]
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

    # Copy Units
    provisioner "file" {
        source = "conf/bastion/units"
        destination = "/home/ubuntu"
        connection {
            user = "ubuntu"
            key_file = "private/.ssh/deis"
        }
    }

}
