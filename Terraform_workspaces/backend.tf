terraform {
  backend "s3" {
    bucket = "mybucket-backend-aditya3340-com"
    key = "state/terraform.tfstate"
    region = "us-east-1"
    encrypt = true

  }
}