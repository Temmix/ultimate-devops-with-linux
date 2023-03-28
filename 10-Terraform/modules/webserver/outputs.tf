output "webserver" {
  value = aws_instance.myapp-server
}

output "webserver_aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image
}
