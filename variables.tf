// This block tells Terraform that we're going to provision AWS resources.

provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
  alias = "us-east-1"
}

// Create a variable for our domain name because we'll be using it a lot.
variable "www_domain_name" {
  default = "www.mpgat.xyz"
}

// We'll also need the root domain (also known as zone apex or naked domain).
variable "root_domain_name" {
  default = "mpgat.xyz"
}
