#!/bin/bash

pushd terraform/
terraform init
terraform apply -var-file="vars.tfvars"
popd

pushd ansible/
# see inventory created
ansible-inventory -i aws_ec2.yaml --graph 

# check connectivity to EC2 instances
sleep 3
ansible ubuntu -i aws_ec2.yaml -m ping

# run playbook
ansible-playbook -i aws_ec2.yaml playbook.yaml
popd
