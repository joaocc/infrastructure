# Records for brandfolder.host
resource "aws_route53_zone" "brandfolder-host" {
   name = "brandfolder.host"
}

# Bastion Host
resource "aws_route53_record" "bastion-brandfolder-host" {
   zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
   name = "bastion.brandfolder.host"
   type = "CNAME"
   ttl = "60"
   records = ["${aws_instance.bastion.public_dns}"]
}

# DeisControl ELB
resource "aws_route53_record" "deisctl-brandfolder-host" {
   zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
   name = "deisctl.brandfolder.host"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.internal.dns_name}"]
}

# Postgres Database
resource "aws_route53_record" "prod-pg-brandfolder-host" {
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "prod.pg.brandfolder.host"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_db_instance.default.address}"]
}

# Redis Primary
resource "aws_route53_record" "prod-1-redis-brandfolder-host" {
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "prod.1.redis.brandfolder.host"
  type = "CNAME"
  ttl = "300"
  records = ["production-001.miqyjj.0001.use1.cache.amazonaws.com"]
}

# Redis Secondary
resource "aws_route53_record" "prod-2-redis-brandfolder-host" {
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "prod.2.redis.brandfolder.host"
  type = "CNAME"
  ttl = "300"
  records = ["production-002.miqyjj.0001.use1.cache.amazonaws.com"]
}