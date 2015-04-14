# Public ELB
resource "aws_elb" "paas" {
  name = "PaaS"

  # Network
  cross_zone_load_balancing = true
  security_groups = ["${aws_security_group.paas-public.id}"]
  subnets = ["${aws_subnet.az-us-east-1a.id}",
             "${aws_subnet.az-us-east-1c.id}"]
  idle_timeout = 1800

  # Listen for inbound HTTPS Connections
  listener {
    lb_port = 443
    lb_protocol = "https"
    instance_port = 80
    instance_protocol = "http"
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
    target = "HTTP:80/health-check"
    interval = 15
  }

}
