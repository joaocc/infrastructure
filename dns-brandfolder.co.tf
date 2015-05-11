# Records for brandfolder.co
resource "aws_route53_zone" "brandfolder-co" {
   name = "brandfolder.co"
}

resource "aws_route53_record" "A-o1-email-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "o1.email.brandfolder.co"
  ttl = 3600
  type = "A"
  records = ["198.37.149.122"]
}

resource "aws_route53_record" "A-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "brandfolder.co"
  ttl = 3600
  type = "A"
  records = ["151.236.219.228"]
}

resource "aws_route53_record" "CNAME-email-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "email.brandfolder.co"
  ttl = 3600
  type = "CNAME"
  records = ["sendgrid.net."]
}

resource "aws_route53_record" "TXT-smtpapi-domainkey-email-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "smtpapi._domainkey.email.brandfolder.co"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

resource "aws_route53_record" "TXT-k1-domainkey-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "k1._domainkey.brandfolder.co"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDj3nyNKMsFzo8ltj3MECUcO9nXAyKnhJCeDaqzCPoBjkzP9Nf4RqqMg9Tf5SYkMhi3VhgYVfzUq9GtZcGow8nIYLktZedfREFvsdrzQNfW8A2L9DQgVaxBQpm5DB9y6kSTNuZKecGstBgBB/4vRFb8X/lk/ZE9vrSOQ8kObCdKqQIDAQAB"]
}

resource "aws_route53_record" "TXT-mailjet-domainkey-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "mailjet._domainkey.brandfolder.co"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7ieiII3+QIYYvGPH3Rn3Ms20YFoRvdJ4vJluPnTJ+BeoOc3/KG3m3akRhftGPokNuhc5zx9ePrOcxE6OIRZRQOiuTAYy4vyBhLOZXqB9PX7Hczpz9XHUkGmy0dsxwjjxRfLZukbfvXREeer6hraueienxwKF1/DWQnLs//N/RewIDAQAB"]
}

resource "aws_route53_record" "TXT-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "brandfolder.co"
  ttl = 3600
  type = "TXT"
  records = ["v=spf1 a mx include:smtp1.uservoice.com include:sendgrid.net v=spf1 include:spf.mailjet.com ~all"]
}

resource "aws_route53_record" "TXT-smtpapi-domainkey-brandfolder-co" {
  zone_id = "${aws_route53_zone.brandfolder-co.zone_id}"
  name = "smtpapi._domainkey.brandfolder.co"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}
