# Records for bf-staging.com
resource "aws_route53_zone" "bf-staging-com" {
   name = "bf-staging.com"
}

# Alias bf-staging.com
resource "aws_route53_record" "A-bf-staging-com" {
   zone_id = "${aws_route53_zone.bf-staging-com.zone_id}"
   name = "bf-staging.com"
   type = "A"

   alias {
     name = "${aws_elb.brandfolder-com.dns_name}"
     zone_id = "${aws_elb.brandfolder-com.zone_id}"
     evaluate_target_health = true
    }
}