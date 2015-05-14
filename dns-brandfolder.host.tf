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

# Etcd ELB
resource "aws_route53_record" "etcd-brandfolder-host" {
   zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
   name = "etcd.brandfolder.host"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.etcd.dns_name}"]
}

# Core machines
resource "aws_route53_record" "core-brandfolder-host" {
  count = "${lookup(var.counts, "core")}"
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "core-${count.index + 1}.brandfolder.host"
  type = "A"
  ttl = "300"
  records = ["${element(aws_eip.deis-core.*.private_ip, count.index)}"]
}

# Core machines
resource "aws_route53_record" "dns-brandfolder-host" {
  count = "${lookup(var.counts, "core")}"
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "dns-${count.index + 1}.brandfolder.host"
  type = "A"
  ttl = "300"
  records = ["${element(aws_eip.deis-core.*.public_ip, count.index)}"]
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
resource "aws_route53_record" "prod-redis-brandfolder-host" {
  zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
  name = "prod.redis.brandfolder.host"
  type = "CNAME"
  ttl = "300"
  records = ["default-redis.miqyjj.ng.0001.use1.cache.amazonaws.com"]
}

# Service discovery in the core
# Etcd ELB
resource "aws_route53_record" "services-brandfolder-host" {
   zone_id = "${aws_route53_zone.brandfolder-host.zone_id}"
   name = "services.brandfolder.host"
   type = "NS"
   ttl = "10800"
   records = ["${split("|", replace(join("|", aws_route53_record.dns-brandfolder-host.*.name), "|", ".|"))}."]
}