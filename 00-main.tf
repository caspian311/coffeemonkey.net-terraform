# Configure the AWS Provider

provider "aws" {
  shared_credentials_file = "/Users/matt.todd/.aws/credentials"
  region = "us-east-1"
}

variable "www_domain_name" {
  default = "www.coffeemonkey.net"
}

variable "root_domain_name" {
  default = "coffeemonkey.net"
}

terraform {
  backend "s3" {
    bucket = "coffeemonkey-terraform-remote-state"
    key = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    bucket = "coffeemonkey-terraform-remote-state"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}
