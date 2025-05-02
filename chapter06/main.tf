provider "aws" {
  region = "us-east-1"
  profile  = "default"
}
module "vpc" {
  source = "./dataplane/network"
}
module "cluster" {
  source = "./controlplane"
  enis_subnet_ids = module.vpc.eni_subnet_ids
}

module "nodes" {
  source = "./dataplane/nodes"
  cluster_name = module.cluster.cluster_name
  subnets_id =  module.vpc.private_subnet_ids
  security_group_id = module.cluster.cluster_security_group_id
}

