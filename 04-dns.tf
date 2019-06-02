// setup DNS

resource "aws_route53_zone" "zone" {
  name = "${var.root_domain_name}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.zone.zone_id}"
  name = "${var.www_domain_name}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.www_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.www_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
