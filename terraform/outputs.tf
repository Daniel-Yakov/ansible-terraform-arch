output "ec2_public_ips" {
  value = [for ec2 in module.ec2_instance : ec2.public_ip]
}