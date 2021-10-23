terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "testnetologybucket"
    key    = "~/.keys"
    region = "us-west-2"
  }
}
