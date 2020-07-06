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
