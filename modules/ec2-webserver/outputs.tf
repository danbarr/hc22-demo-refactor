output "instance_arn" {
  description = "ARN of the deployed instance"
  value       = aws_instance.this.arn
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = var.public_facing ? aws_instance.this.public_ip : null
}

output "public_dns" {
  description = "Public DNS name of the instance"
  value       = var.public_facing ? aws_instance.this.public_dns : null
}