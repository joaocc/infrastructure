resource "aws_security_group" "postgres" {
  name = "Postgres-Database"
  description = "Postgres"
  vpc_id = "${aws_vpc.main.id}"

  # Allow Mode Analytics
  ingress {
    protocol = "tcp"
    from_port = 5432
    to_port = 5432
    cidr_blocks = [
      "54.68.30.98/32",
      "54.68.45.3/32",
      "54.164.204.122/32",
      "54.172.100.146/32",
    ]
  }

  # Allow the workers and the core
  ingress {
    protocol = "tcp"
    from_port = 5432
    to_port = 5432
    security_groups = [
      "${aws_security_group.core.id}",
      "${aws_security_group.worker.id}",
    ]
  }

  # Allow the brandfolder office
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "${file("private/misc/office-ip")}/32",
      "${file("private/misc/office-ip-2")}/32"
    ]
  }

  lifecycle { create_before_destroy = true }

}
