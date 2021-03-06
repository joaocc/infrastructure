# Allow for public DNS
resource "aws_security_group" "core" {
  name = "Core-Machine"
  description = "Core Machines"
  vpc_id = "${aws_vpc.main.id}"

  # Nameservers
  ingress {
      from_port = 53
      to_port = 53
      protocol = "udp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow elasticsearch to the office
  ingress {
      from_port = 9200
      to_port = 9200
      protocol = "tcp"
      cidr_blocks = [
        "${trimspace(file("private/misc/office-ip"))}/32",
        "${trimspace(file("private/misc/office-ip-2"))}/32"
      ]
  }

  lifecycle { create_before_destroy = true }

}
