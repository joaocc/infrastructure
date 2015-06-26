# Records for brandfolder.com
resource "aws_route53_zone" "brandfolder-com" {
   name = "brandfolder.com"
}

# Subdomains to Brandfolder.com
resource "aws_route53_record" "STAR-brandfolder-com" {
   zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
   name = "*.brandfolder.com"
   type = "CNAME"
   ttl = 3600
   records = ["${aws_elb.brandfolder-com.dns_name}"]
}

# Alias Brandfolder.com to the ELB
resource "aws_route53_record" "brandfolder-com" {
   zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
   name = "brandfolder.com"
   type = "A"

   alias {
     name = "${aws_elb.brandfolder-com.dns_name}"
     zone_id = "${aws_elb.brandfolder-com.zone_id}"
     evaluate_target_health = true
    }
}

resource "aws_route53_record" "A-video-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "video.brandfolder.com"
  ttl = 3600
  type = "A"
  records = ["151.236.219.228"]
}

resource "aws_route53_record" "A-o1-email-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "o1.email.brandfolder.com"
  ttl = 3600
  type = "A"
  records = ["198.37.149.122"]
}

resource "aws_route53_record" "A-go-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "go.brandfolder.com"
  ttl = 3600
  type = "A"
  records = ["151.236.219.228"]
}

resource "aws_route53_record" "CNAME-email-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "email.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["sendgrid.net."]
}

resource "aws_route53_record" "CNAME-blogs-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "blogs.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["548041.group41.sites.hubspot.net."]
}

resource "aws_route53_record" "CNAME-bites-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "bites.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["548041.group41.sites.hubspot.net."]
}

resource "aws_route53_record" "CNAME-pages-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "pages.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["548041.group41.sites.hubspot.net."]
}

resource "aws_route53_record" "CNAME-f22f7bd4d53dc388fb463faec130df49-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "f22f7bd4d53dc388fb463faec130df49.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["verify.bing.com."]
}

resource "aws_route53_record" "CNAME-help-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "help.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["brandfolder.uservoice.com."]
}

resource "aws_route53_record" "CNAME-info-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "info.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["unbouncepages.com."]
}

resource "aws_route53_record" "CNAME-images-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "images.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["d21oh8fj97neu1.cloudfront.net."]
}

resource "aws_route53_record" "CNAME-start-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "start.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "CNAME-sites-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "sites.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "CNAME-calendar-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "calendar.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "CNAME-mail-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "mail.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "CNAME-zip-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "zip.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ssl.brandfolder.ninja."]
}

resource "aws_route53_record" "CNAME-3E8FC4431404E8525E0CB95DD0CF24D2-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "3e8fc4431404e8525e0cb95dd0cf24d2.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["5533886D972BD69336C049E0FDAB416495FDEAE7.comodoca.com."]
}

resource "aws_route53_record" "CNAME-staging-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "staging.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["brandfolder-staging.brandfolder.com."]
}

resource "aws_route53_record" "CNAME-7ea7548390d4-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "7ea7548390d4.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["cname.bitly.com."]
}

resource "aws_route53_record" "CNAME-assets-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "assets.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["d21oh8fj97neu1.cloudfront.net."]
}

resource "aws_route53_record" "CNAME-drive-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "drive.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "CNAME-intercom-domainkey-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "intercom._domainkey.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["131d15b0-cc84-4947-8bd2-2b4a354c0518.dkim.intercom.io."]
}

resource "aws_route53_record" "CNAME-static-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "static.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["d2r5j2eb686xip.cloudfront.net."]
}

resource "aws_route53_record" "CNAME-ractive-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "ractive.brandfolder.com"
  ttl = 3600
  type = "CNAME"
  records = ["d2r5j2eb686xip.cloudfront.net."]
}

resource "aws_route53_record" "MX-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "brandfolder.com"
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

resource "aws_route53_record" "SRV-jabber-tcp-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "_jabber._tcp.brandfolder.com"
  ttl = 3600
  type = "SRV"
  records = [
    "5 0 5269 xmpp-server.l.google.com.",
    "20 0 5269 xmpp-server1.l.google.com.",
    "20 0 5269 xmpp-server2.l.google.com.",
    "20 0 5269 xmpp-server3.l.google.com.",
    "20 0 5269 xmpp-server4.l.google.com."
  ]
}

resource "aws_route53_record" "SRV-xmpp-client-tcp-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "_xmpp-client._tcp.brandfolder.com"
  ttl = 3600
  type = "SRV"
  records = [
    "5 0 5222 xmpp.l.google.com.",
    "5 0 5269 xmpp-server.l.google.com.",
    "20 0 5269 xmpp-server1.l.google.com.",
    "20 0 5269 xmpp-server2.l.google.com.",
    "20 0 5269 xmpp-server3.l.google.com.",
    "20 0 5269 xmpp-server4.l.google.com.",
    "20 0 5222 alt1.xmpp.l.google.com.",
    "20 0 5222 alt2.xmpp.l.google.com.",
    "20 0 5222 alt3.xmpp.l.google.com.",
    "20 0 5222 alt4.xmpp.l.google.com."
  ]
}

resource "aws_route53_record" "TXT-smtpapi-domainkey-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "smtpapi._domainkey.brandfolder.com"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

resource "aws_route53_record" "TXT-smtpapi-domainkey-email-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "smtpapi._domainkey.email.brandfolder.com"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

resource "aws_route53_record" "TXT-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "brandfolder.com"
  ttl = 3600
  type = "TXT"
  records = [
    "v=spf1 a include:_spf.google.com ~all",
    "google-site-verification=52y1mQwB1FJgSPp03JBxSythvB-JxFhoGce9Mb4LZ8w",
    "google-site-verification=fpYi_aBU0xQkIQ1h7tHqW3hBV0x37b5poElRLUzpKeM",
    "google-site-verification=Pg2cNGAvmgs9WlWoEA3NbNlKNDKRNGE7RwThK1lVk4s",
    "google-site-verification=uX3oSt2cKp8NJaosqBdUeEgSRwldAjn305U2DHGdEsk",
    "google-site-verification=xUSCk_okRwv1JfD6JNED5jqbSYz-TXIiOHlcDvlFpo4",
    "v=spf1 a mx include:_spf.google.com include:smtp1.uservoice.com include:spf.mail.intercom.io include:sendgrid.net ~all"
  ]
}

resource "aws_route53_record" "TXT-google-domainkey-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "google._domainkey.brandfolder.com"
  ttl = 3600
  type = "TXT"
  records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeyWtKog0/Uw/ll4eaxfy5tGjOBDK3LVJC5X/7WCz2/Igr/QuQeyUGxkO0d7cpqzHRmat2V4idmWPad07aJJUAE0mOky831qfiBqOjOoCfYQwiAgPT6Hb+MNDPjcnnIUGbWDGHWPTGFRpw3az7hLaxPuo5ggGgDHMe9YcX9jl2RwIDAQAB"]
}

resource "aws_route53_record" "TXT-mandrill-domainkey-brandfolder-com" {
  zone_id = "${aws_route53_zone.brandfolder-com.zone_id}"
  name = "mandrill._domainkey.brandfolder.com"
  ttl = 3600
  type = "TXT"
  records = ["k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrLHiExVd55zd/IQ/J/mRwSRMAocV/hMB3jXwaHH36d9NaVynQFYV8NaWi69c1veUtRzGt7yAioXqLj7Z4TeEUoOLgrKsn8YnckGs9i3B3tVFB+Ch/4mPhXWiNfNdynHWBcPcbJ8kjEQ2U8y78dHZj1YeRXXVvWob2OaKynO8/lQIDAQAB;"]
}
