resource "aws_security_group" "router" {
  name = "Deis-Router"
  description = "Deis Router"
  vpc_id = "${aws_vpc.main.id}"

  # Allow http traffic
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }

  # Allow https traffic
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }

  # Allow git deploys
  ingress {
      from_port = 2222
      to_port = 2222
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }

  lifecycle { create_before_destroy = true }

}