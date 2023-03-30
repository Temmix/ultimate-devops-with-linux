locals {
  sensitive_data = jsondecode(file("env.dev.json"))
}

provider "aws" {
  region     = local.sensitive_data.region
  access_key = local.sensitive_data.access_key
  secret_key = local.sensitive_data.secret_key
}
# setting up variable and assigning the variable in terraform.tfvars

variable "vpc_cidr_block" {}

variable "subnet_cidr_block" {}

variable "env_prefix" {}

variable "avail_zone" {}

variable "my_ip" {}

variable "instance_type" {}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "development-vpc"
    env  = var.env_prefix
  }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id            = aws_vpc.myapp-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
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

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_route_table" "myapp-route-table" {
  vpc_id = aws_vpc.myapp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name : "${var.env_prefix}-rtb"
  }
}

resource "aws_security_group" "myapp-sg" {
  name   = "myapp-sg"
  vpc_id = aws_vpc.myapp-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name : "${var.env_prefix}-sG"
  }
}

resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id      = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.myapp-route-table.id
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-*-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "terra-ec2-key-pair"
  public_key = local.sensitive_data.ssh-key
}

resource "aws_instance" "myapp-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

resource "aws_instance" "myapp-server-2" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  tags = {
    Name = "${var.env_prefix}-server-2"
  }
}

resource "aws_instance" "myapp-server-3" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  tags = {
    Name = "${var.env_prefix}-server-3"
  }
}
output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image
}
output "dev-vpc" {
  value = aws_vpc.myapp-vpc.id
}

output "myapp-public-ip" {
  value = aws_instance.myapp-server.public_ip
}
