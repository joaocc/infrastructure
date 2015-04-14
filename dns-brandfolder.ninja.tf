# brandfolder.ninja is our deis cluster
resource "aws_route53_zone" "brandfolder-ninja" {
   name = "brandfolder.ninja"
}

# Subdomains to brandfolder.ninja
resource "aws_route53_record" "STAR-brandfolder-ninja" {
   zone_id = "${aws_route53_zone.brandfolder-ninja.zone_id}"
   name = "*.brandfolder.ninja"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.www.dns_name}"]
}

resource "aws_route53_alias_target" "brandfolder-ninja" {
   zone_id = "${aws_route53_zone.brandfolder-ninja.zone_id}"
   name = "brandfolder.ninja"
   type = "A"
   target = "${aws_elb.www.dns_name}"
   target_zone_id = "${aws_elb.www.hosted_zone_id}"
}