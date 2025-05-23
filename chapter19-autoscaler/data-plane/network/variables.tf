variable "region" {
  default = "us-east-1"
}
variable "cluster_name" {
 default = "autoscaler-cluster"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_subnets_cidr" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "public_subnets_cidr" {
  default   = ["10.0.2.0/24", "10.0.3.0/24"]
}
variable "azs" {
  default  = ["us-east-1a", "us-east-1b"]
}

variable "security_group_id" {
  
}
