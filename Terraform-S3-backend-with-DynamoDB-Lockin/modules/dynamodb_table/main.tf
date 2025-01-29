provider "aws" {
  region = "us-east-1"
}

# resource for terraform state lock

resource "aws_dynamodb_table" "my_table" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = var.lock_id
    type = var.type
  }
}