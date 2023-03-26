variable "region" {
  type = string
  description = "AWS region"
}

variable "vpc" {
    type = object({
        name = string,
        cidr = string,
        public_subnets = list(string)
    })
    description = "Configure the VPC module"
}

variable "ec2" {
  type = object({
    instances = list(string)
    instance_type = string,
    key_name = string,
    sg_name = string
  })
}