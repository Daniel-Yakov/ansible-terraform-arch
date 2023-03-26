region = "eu-central-1"

vpc = {
    name = "Ansible-project",
    cidr = "10.0.0.0/16",
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

ec2 = {
    instances = [ "1" ]
    instance_type = "t2.micro",
    key_name = "daniel-key",
    sg_name = "ansible-instance-sg"
}