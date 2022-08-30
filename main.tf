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

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/user_data.sh")

  vpc_security_group_ids = [aws_security_group.app.id]

  root_block_device {
    volume_size = var.disk_size
  }

  tags = {
    "Name" = "app-instance"
  }
}

resource "aws_security_group" "app" {
  name        = "app-instance-sg"
  description = "Web server access"

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
}
