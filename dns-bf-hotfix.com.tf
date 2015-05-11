# Records for bf-hotfix.com
resource "aws_route53_zone" "bf-hotfix-com" {
   name = "bf-hotfix.com"
}

# Alias bf-hotfix.com
resource "aws_route53_record" "A-bf-hotfix-com" {
   zone_id = "${aws_route53_zone.bf-hotfix-com.zone_id}"
   name = "bf-hotfix.com"
   type = "A"

   alias {
     name = "${aws_elb.www.dns_name}"
     zone_id = "${aws_elb.www.zone_id}"
     evaluate_target_health = true
    }
}

