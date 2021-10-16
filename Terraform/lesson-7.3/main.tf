provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = element(var.instance_options, index(var.instance_options.*.workspace, terraform.workspace)).instance_type
  iam_instance_profile = "omi"
  count                = element(var.instance_options, index(var.instance_options.*.workspace, terraform.workspace)).replica_count

  tags = {
    Name = terraform.workspace
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "ec2_instance_foreach" {
  for_each             = { for option in var.instance_options : option.replica_count => option }
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "each.key.instance_type"
  iam_instance_profile = "omi"
  tags = {
    Name = "{each.key.workspace}-{index(var.instance_options, each.key)}"
  }
}
