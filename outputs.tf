output "public_dns" {
  description = "Public DNS name of the instance."
  value       = module.ec2_webserver.public_dns
}
