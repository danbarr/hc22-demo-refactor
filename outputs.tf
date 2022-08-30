output "public_dns" {
  description = "Public DNS name of the instance."
  value       = aws_instance.app.public_dns
}
