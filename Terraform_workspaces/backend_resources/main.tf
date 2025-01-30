provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mybucket" {

  bucket        = "mybucket-backend-aditya3340-com"
  force_destroy = true

}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "my_bucket_lcc" {
  depends_on = [aws_s3_bucket_versioning.bucket_versioning]
  bucket     = aws_s3_bucket.mybucket.id

  rule {
    id     = "rule1: transition all the state files to glacier after an year"
    status = "Enabled"
    filter {
      and {
        prefix = "state/"
        tags = {
          "enviroment" : terraform.workspace
        }
      }
    }

    transition {
      days          = 365
      storage_class = "GLACIER"
    }

  }

}
