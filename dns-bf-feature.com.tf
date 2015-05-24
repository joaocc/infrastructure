# Records for bf-feature.com
resource "aws_route53_zone" "bf-feature-com" {
   name = "bf-feature.com"
}

# Alias bf-feature.com to the ELB
resource "aws_route53_record" "A-bf-feature-com" {
   zone_id = "${aws_route53_zone.bf-feature-com.zone_id}"
   name = "bf-feature.com"
   type = "A"

   alias {
     name = "${aws_elb.brandfolder-com.dns_name}"
     zone_id = "${aws_elb.brandfolder-com.zone_id}"
     evaluate_target_health = true
    }
}

