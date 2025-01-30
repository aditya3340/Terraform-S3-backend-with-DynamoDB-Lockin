provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://<ip_address>:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "vault_role_id"
      secret_id = "your_vault_secret_id"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "example" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"

  tags = {
    secret = data.vault_kv_secret_v2.example.data["username"]
  }
}