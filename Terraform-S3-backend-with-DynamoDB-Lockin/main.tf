provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ec2_ami = "ami-04b4f1a9cf54c11d0"
  ec2_type = "t2.micro"
}