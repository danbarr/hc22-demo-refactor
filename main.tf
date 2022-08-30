terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  owners = ["099720109477"] # Canonical
}

module "ec2_webserver" {
  source  = "app.terraform.io/dbarr-org/ec2-webserver/aws"
  version = "0.2.0"

  name          = "app-instance"
  ami_id        = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  disk_size     = var.disk_size
  user_data     = file("${path.module}/user_data.sh")
  public_facing = true
}
