# Allow for public DNS
resource "aws_security_group" "worker" {
  name = "Worker-Machine"
  description = "Worker"
  vpc_id = "${aws_vpc.main.id}"

  lifecycle { create_before_destroy = true }
}
