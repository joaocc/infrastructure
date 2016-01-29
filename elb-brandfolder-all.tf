# Public ELB
resource "aws_elb" "brandfolder-all" {
  name = "brandfolder-all"

  # Network
  cross_zone_load_balancing = true
  security_groups = [
    "${aws_security_group.router.id}",
    "${aws_security_group.internal-communication.id}"
  ]
  subnets = ["${aws_subnet.subnet.*.id}"]
  idle_timeout = 60

  # Listen for inbound HTTPS Connections
  listener {
    lb_port = 443
    lb_protocol = "https"
    instance_port = 80
    instance_protocol = "http"
    ssl_certificate_id = "arn:aws:acm:us-east-1:260121740514:certificate/ed9a6976-8392-4901-8517-894fdf330b5c"
  }

  # Inbound HTTP Connections
  listener {
    lb_port = 80
    instance_port = 80
    instance_protocol = "http"
    lb_protocol = "http"
  }

  # Listen for deployments
  listener {
    lb_port = 2222
    lb_protocol = "tcp"
    instance_port = 2222
    instance_protocol = "tcp"
  }

  # Healthcheck against port 80
  health_check {
    healthy_threshold = 4
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:9090/health-check"
    interval = 15
  }

}
