provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../modules/s3_bucket"
  s3_bucket = "mybucket.aditya3340.com"
}

module "dynamodb_table" {
  source = "../modules/dynamodb_table"
  lock_id = "LockID"
  type = "S"
}