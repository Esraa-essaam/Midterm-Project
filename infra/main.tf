
terraform {
 required_version = ">= 1.5.0"

 required_providers {
 aws = {
 source = "hashicorp/aws"
 version = "~> 5.0"
 }
 }
}

provider "aws" {
 region = var.aws_region
}

module "vpc" {
 source = "terraform-aws-modules/vpc/aws"
 version = "~> 5.0"

 name = var.vpc_name
 cidr = var.vpc_cidr
 azs = var.azs
 private_subnets = var.private_subnets
 public_subnets = var.public_subnets
 enable_nat_gateway = var.enable_nat_gateway
 enable_vpn_gateway = var.enable_vpn_gateway

 tags = {
 Terraform = "true"
 Environment = var.environment
 }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  key_name      = "user1"
  monitoring    = true
  subnet_id     = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}