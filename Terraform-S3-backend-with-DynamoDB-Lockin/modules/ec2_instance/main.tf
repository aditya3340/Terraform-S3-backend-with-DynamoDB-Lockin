provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
    ami = var.ec2_ami
    instance_type = var.ec2_type
}