# Records for brandfolder.net
resource "aws_route53_zone" "brandfolder-net" {
   name = "brandfolder.net"
}

resource "aws_route53_record" "A-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "brandfolder.net"
  ttl = 3600
  type = "A"
  records = ["151.236.219.228"]
}

resource "aws_route53_record" "CNAME-email-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "email.brandfolder.net"
  ttl = 3600
  type = "CNAME"
  records = ["r.mailjet.com."]
}

resource "aws_route53_record" "TXT-smtpapi-domainkey-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "smtpapi._domainkey.brandfolder.net"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

resource "aws_route53_record" "TXT-mailjet-domainkey-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "mailjet._domainkey.brandfolder.net"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDp73KT4fLlum0+dUQtKHAKXbhG4G48Jhp03lZhUlA8Q4O097Q1nbXNja5vRb/lvjxyp8nFhbc/g4bbbkJMzKJcMFe3kX9lYLfAwC70yLv1tgJPt6t+Xy4Li1yVYG+QEcczdIdeqAtWlvdpPvY3piiJdBvf9Q2T1aQYIl2wHq+JJwIDAQAB"]
}

resource "aws_route53_record" "TXT-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "brandfolder.net"
  ttl = 3600
  type = "TXT"
  records = [
    "v=spf1 a include:spf.mailjet.com ?all",
    "google-site-verification=owYdC8tcvcFSq7tOLGIS-Ddy0RAX-bUpb-CcB2o5x14"
  ]
}

resource "aws_route53_record" "MX-brandfolder-net" {
  zone_id = "${aws_route53_zone.brandfolder-net.zone_id}"
  name = "brandfolder.net"
  ttl = 3600
  type = "MX"
  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com."
  ]
}