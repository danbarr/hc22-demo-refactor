variable "instance_type" {
  type        = string
  description = "Instance type to deploy."
  default     = "t3.micro"
}

variable "disk_size" {
  type        = number
  description = "Size in GB of the root disk."
  default     = 10
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy into."
  default     = "eu-west-1"
}
