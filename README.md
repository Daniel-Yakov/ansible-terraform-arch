# Provisioning Infrastructure with Terraform and Configuring EC2 Instances with Ansible
This project demonstrates how to use Terraform to provision infrastructure on AWS, including VPC and EC2 instances, and then use Ansible to configure those created instances. The Ansible playbook used in this project installs Docker and runs an Nginx container on each EC2 instance. The dynamic inventory feature of Ansible is used to automatically discover the EC2 instances and configure them.

## Getting Started
To get started with this project, you will need to have the following prerequisites:

* An AWS account with permissions to create VPC, EC2 instances, and security groups.
* Terraform installed on your local machine.
* Ansible installed on your local machine.
* AWS CLI installed on your local machine.
* Boto3 installed on your local machine (required for the amazon.aws.aws_ec2 inventory plugin).

Once you have these prerequisites, you can follow the steps below to deploy the infrastructure:
1. Clone this repository to your local machine.
2. Run the following command:
```
./deploy-nginx.sh
```

## Further Improvements
This project is a basic example of how to use Terraform and Ansible together to provision and configure infrastructure. There are a number of improvements that could be made to this project, including:

* Using remote state for Terraform instead of local state.
* Adding an Application Load Balancer to distribute traffic across the EC2 instances.
* Using a more complex Ansible playbook to install and configure multiple applications.