provider "aws" {
  region = "us-east-1"
  profile  = "default"
}
module "vpc" {
  source = "./dataplane/network"
}
module "eks" {
  source = "./controlplane"
  private_subnet_ids = module.vpc.private_subnet_ids
}
module "nodes" {
  source = "./dataplane/nodes"
  cluster_name = module.eks.cluster_name
  node_name = "private-node-group"
  subnets_id =  module.eks.private_subnet_ids
  security_group_id = module.eks.cluster_security_group_id
}

