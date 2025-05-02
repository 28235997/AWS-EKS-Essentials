module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr
  azs             = [data.aws_availability_zones.zones.names[0], data.aws_availability_zones.zones.names[1]]
  #var.azs
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr
  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  one_nat_gateway_per_az = false
  # Make EKS nodes public. 
  map_public_ip_on_launch = true
  private_subnet_tags = {
    "autoscaler.sh/discovery"  = var.cluster_name
    "kubernetes.io/role/internal-elb"               = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb"                        = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

data "aws_availability_zones" "zones" {
   state ="available"
}

