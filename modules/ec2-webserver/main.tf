terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.2"
    }
  }
}

resource "aws_security_group" "webserver" {
  name        = "${var.name}-sg"
  description = "Web server access"

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_facing ? "0.0.0.0/0" : "172.31.0.0/16"]
    self        = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  user_data     = var.user_data

  associate_public_ip_address = var.public_facing
  vpc_security_group_ids      = [aws_security_group.webserver.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp3"
    iops        = 3000
    throughput  = 125
    encrypted   = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    "Name" = var.name
  }
}
