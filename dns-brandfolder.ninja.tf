# brandfolder.ninja is our deis cluster
resource "aws_route53_zone" "brandfolder-ninja" {
   name = "brandfolder.ninja"
}

# SSL into to brandfolder.ninja
resource "aws_route53_record" "ssl-brandfolder-ninja" {
   zone_id = "${aws_route53_zone.brandfolder-ninja.zone_id}"
   name = "ssl.brandfolder.ninja"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.www.dns_name}"]
}

# Subdomains to brandfolder.ninja
resource "aws_route53_record" "STAR-brandfolder-ninja" {
   zone_id = "${aws_route53_zone.brandfolder-ninja.zone_id}"
   name = "*.brandfolder.ninja"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.deis.dns_name}"]
}
