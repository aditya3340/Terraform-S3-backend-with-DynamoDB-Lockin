provider "aws" {
  region = "us-east-1"
}

variable "instance_ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
}

variable "enviroment" {
  description = "value"
}

resource "aws_instance" "ec2_instance" {
  ami = var.instance_ami
  instance_type = var.instance_type

  tags = {
    "Enviroment" : var.enviroment
  }
}