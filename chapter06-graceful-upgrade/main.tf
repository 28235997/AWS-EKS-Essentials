provider "aws" {
  region = "us-east-1"
  profile  = "default"
}
module "vpc" {
  source = "./dataplane/network"
}
module "eks" {
  source = "./controlplane"
  enis_subnet_ids = module.vpc.eni_subnet_ids
}


module "node-group-1" {
  source = "./dataplane/node-group-1"
  cluster_name = module.eks.cluster_name
  subnets_id =  module.vpc.private_subnet_ids
}

/*
module "node-group-2" {
  source = "./dataplane/node-group-2"
  cluster_name = module.eks.cluster_name
  subnets_id =  module.vpc.private_subnet_ids
}
*/