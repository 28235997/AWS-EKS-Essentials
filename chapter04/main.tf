provider "aws" {
  region = "us-east-1"
  profile  = "joyce-role"
}
#create vpc
module "vpc" {
  source = "./data-plane/network"
}
#create eni in the dataplane (step x)
module "cluster" {
  source = "./control-plane"
  eni_subnet_ids = module.vpc.eni_subnet_ids
  vpc_id = module.vpc.vpc_id
}
module "nodes" {
  source = "./data-plane/nodes"
  cluster_name = module.cluster.cluster_name
  subnet_ids =  module.vpc.private_subnet_ids
  cluster_security_group_id = module.cluster.cluster_security_group_id
}
module "instance" {
  source = "./bastion"
  subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id = module.vpc.vpc_id
}
