provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "control-plane" {
  source = "./control-plane"
  private_subnets_id = module.vpc.private_subnets
}

module "vpc" {
  source = "./data-plane/network"
  security_group_id  = module.control-plane.cluster_security_group_id
}

module "node-grp" {
  source = "./data-plane/nodes"
  private_subnets_id = module.vpc.private_subnets
  cluster_name =  module.control-plane.cluster_name
}




