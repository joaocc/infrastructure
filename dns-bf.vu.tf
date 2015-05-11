# Records for bf-staging.com
resource "aws_route53_zone" "bf-vu" {
   name = "bf.vu"
}

resource "aws_route53_record" "A-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "bf.vu"
  ttl = 3600
  type = "A"
  records = ["162.243.199.47"]
}

resource "aws_route53_record" "71CDE341CEF6A8E1C863429950BB2017-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "71cde341cef6a8e1c863429950bb2017.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["20070E0D8C90D535D3E6D93EA0F46FD007013E8F.comodoca.com"]
}

resource "aws_route53_record" "agency-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "agency.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["www.netlify.com"]
}

resource "aws_route53_record" "example-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "example.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["www.netlify.com"]
}

resource "aws_route53_record" "share-bf-vu" {
  zone_id = "${aws_route53_zone.bf-vu.zone_id}"
  name = "share.bf.vu"
  ttl = 3600
  type = "CNAME"
  records = ["cname.bitly.com"]
}