
resource "aws_s3_bucket" "web_site_bucket" {
  bucket = "coffeemonkey.net"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}


resource "aws_s3_bucket" "www_web_site_bucket" {
  bucket = "www.coffeemonkey.net"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

