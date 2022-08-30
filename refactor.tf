moved {
  from = aws_instance.app
  to   = module.ec2_webserver.aws_instance.this
}

moved {
  from = aws_security_group.app
  to   = module.ec2_webserver.aws_security_group.webserver
}