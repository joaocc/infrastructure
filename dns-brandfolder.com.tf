# Records for brandfolder.com
resource "aws_route53_zone" "brandfolder-com" {
   name = "brandfolder.com"
}

# Subdomains to Brandfolder.com
resource "aws_route53_record" "STAR-brandfolder-com" {
   zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
   name = "*.brandfolder.com"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.www.dns_name}"]
}

resource "aws_route53_alias_target" "brandfolder-com" {
   zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
   name = "brandfolder.com"
   type = "A"
   target = "${aws_elb.www.dns_name}"
   target_zone_id = "${aws_elb.www.hosted_zone_id}"
}