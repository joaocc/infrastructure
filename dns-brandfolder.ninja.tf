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
   records = ["${aws_elb.brandfolder-all.dns_name}"]
}
