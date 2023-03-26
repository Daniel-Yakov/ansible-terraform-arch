# list of AZs matching the region configured in the aws provider
data "aws_availability_zones" "available" {
  state = "available"
}

# Get information abount the Ubuntu AMI matching the region configured in the aws provider
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230208" ]
  }
}

# Create vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.vpc.public_subnets
}

# locals Relevent for the ec2 module
locals {
  # the length of the public subnets list
  public_subnets_length = length(module.vpc.public_subnets)
}

# Create EC2 instances 
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(var.ec2.instances)

  name = "ansible-demo-${each.key}"

  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = var.ec2.instance_type
  key_name               = var.ec2.key_name
  vpc_security_group_ids = [ aws_security_group.ansible_instance_sg.id ] 
  # each EC2 instance in different subnet, round-robin style
  subnet_id              = module.vpc.public_subnets[index(tolist(toset(var.ec2.instances)), each.key) % local.public_subnets_length]

  depends_on = [
    module.vpc,
    aws_security_group.ansible_instance_sg
  ]
}

# Security Group for the EC2 instances
resource "aws_security_group" "ansible_instance_sg" {
  name        = var.ec2.sg_name
  description = "security group for the ansible instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.ec2.sg_name
  }

  depends_on = [
    module.vpc
  ]
}
