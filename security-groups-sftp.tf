# Public Bastion
resource "aws_security_group" "sftp" {
  name = "SFTP"
  description = "SFTP Services"
  vpc_id = "${aws_vpc.main.id}"

  # Allow inbound SSH
  ingress {
      from_port = 10000
      to_port = 65000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle { create_before_destroy = true }

}
