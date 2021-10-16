provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu*"]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}


resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  iam_instance_profile = "omi"
  
  tags = {
    Name = "HelloWorld"
  }
}

