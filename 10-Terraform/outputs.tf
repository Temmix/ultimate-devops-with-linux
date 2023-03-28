output "aws_ami_id" {
  value = module.myapp-webser.webserver_aws_ami_id
}

output "dev-vpc" {
  value = aws_vpc.myapp-vpc.id
}

output "myapp-public-ip" {
  value = module.myapp-webser.webserver.public_ip
}
