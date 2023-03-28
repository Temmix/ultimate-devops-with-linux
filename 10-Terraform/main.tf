locals {
  sensitive_data = jsondecode(file("env.dev.json"))
}

provider "aws" {
  region     = local.sensitive_data.region
  access_key = local.sensitive_data.access_key
  secret_key = local.sensitive_data.secret_key
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "dev-vpc"
    env  = var.env_prefix
  }
}

module "myapp-subnet" {
  source            = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  env_prefix        = var.env_prefix
  avail_zone        = var.avail_zone
  vpc_id            = aws_vpc.myapp-vpc.id
}


module "myapp-webser" {
  source                 = "./modules/webserver"
  vpc_id                 = aws_vpc.myapp-vpc.id
  my_ip                  = var.my_ip
  env_prefix             = var.env_prefix
  subnet_id              = module.myapp-subnet.subnet-output.id
  route_table_id         = module.myapp-subnet.route-table-output.id
  sensitive_data_ssh_key = local.sensitive_data.ssh-key
  instance_type          = var.instance_type
  avail_zone             = var.avail_zone
}

# Query existing resource, use data key word
data "aws_vpc" "existing-default-vpc" {
  default = true
}

