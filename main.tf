provider "aws" {
  version = "~> 2.69"
  region  = "eu-west-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "blog.otso.fr"
  arn    = "arn:aws:s3:::blog.otso.fr"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
  }
}

provider "cloudflare" {
  version   = "~> 2.8"
  api_token = var.cloudflare_token
}

resource "cloudflare_record" "blog" {
  zone_id    = var.cloudflare_zone_id
  type       = "CNAME"
  name       = "blog"
  value      = "blog.otso.fr.s3-website-eu-west-1.amazonaws.com"
  proxied    = true
  depends_on = [aws_s3_bucket.b]
}
