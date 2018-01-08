resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.web_site_bucket.bucket_domain_name}"
    origin_id   = "websiteS3Origin"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "websiteS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.ssl_cert.arn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
