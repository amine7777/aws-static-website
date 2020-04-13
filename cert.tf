resource "aws_acm_certificate" "certificate" {
  // We want a wildcard cert so we can host subdomains later.
  provider = aws.us-east-1
  domain_name       = "*.${var.root_domain_name}"
  validation_method = "DNS"
  // We also want the cert to be valid for the root domain even though we'll be
  // redirecting to the www. domain immediately.
  subject_alternative_names = ["${var.root_domain_name}"]
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]
}
