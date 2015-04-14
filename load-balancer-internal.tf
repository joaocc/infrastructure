# Internal deisctl ELB
resource "aws_elb" "internal" {
  name = "internal"

  # Network
  cross_zone_load_balancing = true
  internal = true
  security_groups = ["${aws_security_group.bastion.id}"]
  subnets = ["${aws_subnet.az-us-east-1a.id}",
             "${aws_subnet.az-us-east-1c.id}"]
  idle_timeout = 1800

  # Forward SSH 2323 to 22
  listener {
    lb_port = 2323
    lb_protocol = "tcp"
    instance_port = 22
    instance_protocol = "tcp"
  }

  # Check SSH Health
  health_check {
    healthy_threshold = 4
    unhealthy_threshold = 2
    timeout = 5
    target = "TCP:22"
    interval = 15
  }

}
