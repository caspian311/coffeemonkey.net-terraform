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

