provider "aws" {
  region = "us-east-1"
  profile  = "default"
}

#create eni in the dataplane (step x)
module "cluster" {
  source = "./controlplane"
  #ENI subnet = private subnets
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "vpc" {
  source = "./dataplane/network"
  cluster_security_group_id = module.cluster.cluster_security_group_id
}
module "nodes" {
  source = "./dataplane/nodes"
  cluster_name = module.cluster.cluster_name
  subnet_ids =  module.vpc.private_subnet_ids
}
