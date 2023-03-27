
locals {
  sensitive_data = jsondecode(file("env.dev.json"))
}

provider "aws" {
  region     = local.sensitive_data.region
  access_key = local.sensitive_data.access_key
  secret_key = local.sensitive_data.secret_key
}
# setting up variable and assigning the variable in terraform.tfvars

variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  default     = "10.0.10.0/24"
  type        = string
}

variable "environment" {
  description = "environment"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "development-vpc"
    env  = var.environment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "eu-west-2a"
  tags = {
    Name = "dev-subnet-1-development"
  }
}

# Query existing resource, use data key word

data "aws_vpc" "existing-default-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing-default-vpc.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "default-subnet-2-development"
  }
}

output "development-vpc" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-1" {
  value = aws_subnet.dev-subnet-1.id
}

output "dev-subnet-2" {
  value = aws_subnet.dev-subnet-2.id
}
