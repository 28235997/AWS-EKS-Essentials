provider "aws" {
  region = "us-east-1"
  profile = "default"
}

module "vpc" {
  source = "./data-plane/network"
}
module "control-plane" {
  source = "./control-plane"
  private_subnets_id = module.vpc.private_subnet_ids
}

module "node-grp" {
  source = "./data-plane/nodes"
  private_subnets_id = module.vpc.private_subnet_ids
  cluster_name =  module.control-plane.cluster_name
}
