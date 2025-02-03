
variable "cidr_block_range" {
  description = "value"
  default = "10.0.0.0/16"
}

variable "cidr_block_range_sub1" {
  description = "value"
  default = "10.0.0.0/24"
}


variable "cidr_block_range_sub2" {
  description = "value"
  default = "10.0.1.0/24"
}

variable "bucket_name" {
  description = "value"
}

variable "instance_ami" {
  description = "value"
  default = ""
}

variable "instance_type" {
  description = "value"
  default = "t2.micro"
}

variable "key_name" {
  description = "value"
  default = "test_ec2_keypair"
}

variable "userdata" {
  description = "value"
  type = string
}

variable "userdata1" {
  description = "value"
  type = string
}
