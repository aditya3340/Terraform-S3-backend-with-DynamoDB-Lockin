provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "value"
}

variable "type" {
  description = "value"
  type = map(string)
  default = {
    "dev" : "t2.micro"
    "stage" : "t2.medium"
    "prod" : "t2.xlarge"
  }
}


module "ec2_instance" {
  source = "./modules/ec2_instance"
  instance_ami = var.ami
  instance_type = lookup(var.type, terraform.workspace, "t2.micro")
  enviroment = terraform.workspace
}