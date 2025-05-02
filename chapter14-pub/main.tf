provider "aws" {
  region = "us-east-1"
  profile  = "default"
}

#create eni in the dataplane (step x)
module "cluster" {
  source = "./controlplane"
  #ENI subnet = public subnets
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "vpc" {
  source = "./dataplane/network"
  cluster_security_group_id = module.cluster.cluster_security_group_id
}
module "nodes" {
  source = "./dataplane/nodes"
  cluster_name = module.cluster.cluster_name
  security_group_id =  module.cluster.cluster_security_group_id
  subnet_ids =  module.vpc.public_subnet_ids
}
