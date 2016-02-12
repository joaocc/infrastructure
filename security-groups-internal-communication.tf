# Allow for public DNS
resource "aws_security_group" "internal-communication" {
  name = "Internal-Communication"
  description = "Internal Communication"
  vpc_id = "${aws_vpc.main.id}"

  # Allow SSH from the bastion hosts
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }

  # Allow Flannel to communicate throughout the VPC
  ingress {
      from_port = 8285
      to_port = 8285
      protocol = "udp"
      cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }

  # Allow etcd to communicate throughout the VPC
  ingress {
      from_port = 4001
      to_port = 4001
      protocol = "tcp"
      cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }

  ingress {
      from_port = 2379
      to_port = 2379
      protocol = "tcp"
      cidr_blocks = ["${aws_vpc.main.cidr_block}"]
  }

  # Allow all internal communication, and communication from the routers
  # This should be deprecated when all the traffic can go over flannel
  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["${aws_vpc.main.cidr_block}"]
    self = true
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
