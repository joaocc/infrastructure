# HTTPS and HTTP only for production public facing applications
resource "aws_security_group" "www" {
  name = "www"
  description = "Security group for public traffic to http, https"
  vpc_id = "${aws_vpc.paas.id}"

  # Allow inbound HTTP
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group to Enable Access to the PaaS cluster
resource "aws_security_group" "paas-public" {
  name = "PaaS-Public"
  description = "ELB security group for public traffic http, https, and git deploys"
  vpc_id = "${aws_vpc.paas.id}"

  # Allow inbound HTTP
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      # Todo: Need a certificate for the PaaS domain with wildcard.
  }

  # Allow inbound SSH git deploys
  ingress {
      from_port = 2222
      to_port = 2222
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private VPC
resource "aws_security_group" "paas-private" {
  name = "PaaS-Private"
  description = "Enable public SSH and intra-VPC communication"
  vpc_id = "${aws_vpc.paas.id}"

  # Allow SSH from the bastion hosts
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      security_groups = ["${aws_security_group.bastion.id}"]
  }

  # Allow HTTP/S from the PaaS Public ELB
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.paas-public.id}"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = ["${aws_security_group.paas-public.id}"]
  }

  # Allow HTTP/S from the WWW ELB
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = ["${aws_security_group.www.id}"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      security_groups = ["${aws_security_group.www.id}"]
  }

  # Allow ssh git deploys from the PaaS Public ELB
  ingress {
      from_port = 2222
      to_port = 2222
      protocol = "tcp"
      security_groups = ["${aws_security_group.paas-public.id}"]
  }

  # Allow all internal communication
  ingress {
    from_port = 0
    to_port = 65535
    protocol = -1
    self = true
  }
}

# Private DB
resource "aws_security_group" "rds" {
  name = "rds"
  description = "Enable communication between the paas vpc and the database"
  vpc_id = "${aws_vpc.paas.id}"

  # Allow communication from vpc hosts
  ingress {
    protocol = "tcp"
    from_port = 5432
    to_port = 5432
    security_groups = ["${aws_security_group.paas-private.id}"]
  }

  # Allow Mode Analytics
  ingress {
    protocol = "tcp"
    from_port = 5432
    to_port = 5432
    cidr_blocks = ["54.68.30.98/32", "54.68.45.3/32", "54.164.204.122/32", "54.172.100.146/32"]
  }
}

# Public Bastion
resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Enable public SSH to the bastion host"
  vpc_id = "${aws_vpc.paas.id}"

  # Allow balanced ssh connections
  ingress {
      from_port = 2323
      to_port = 2323
      protocol = "tcp"
      self = true
  }

  # Allow inbound SSH
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

}
