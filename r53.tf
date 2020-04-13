
data "aws_route53_zone" "myzone" {
  name = "${var.root_domain_name}"
}
# This record creates a CNAME
resource "aws_route53_record" "validation" {
  name    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}

# This record creates an ALIAS
resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.myzone.zone_id}"
  name    = "${var.www_domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.www_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.www_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
