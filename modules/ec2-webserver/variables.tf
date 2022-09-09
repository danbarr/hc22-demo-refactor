variable "name" {
  type        = string
  description = "A name for the instance."
}

variable "ami_id" {
  type        = string
  description = "ID of the source AMI to deploy."

  validation {
    condition = can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))
    error_message = "The ami_id must be a valid AMI identifier."
  }
}

variable "instance_type" {
  type        = string
  description = "The type of instance to deploy."
  default     = "t3.micro"
}

variable "user_data" {
  type        = string
  description = "User data script to initialize the instance."
  default     = ""
}

variable "disk_size" {
  type        = number
  description = "Size of the disk to provision, in GB. Must be between 10 and 100 GB."
  default     = 10

  validation {
    condition = var.disk_size >= 10 && var.disk_size <= 100
    error_message = "The disk_size must be between 10 and 100."
  }
}

variable "public_facing" {
  type        = bool
  description = "Whether the web server should be public-facing. If true, a public IP is assigned and security group permits access from the internet."
  default     = false
}