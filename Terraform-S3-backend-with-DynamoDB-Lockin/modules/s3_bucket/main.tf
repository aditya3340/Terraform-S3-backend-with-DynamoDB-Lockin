provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket
  tags = {
    Enviroment = "Dev"
  }
}