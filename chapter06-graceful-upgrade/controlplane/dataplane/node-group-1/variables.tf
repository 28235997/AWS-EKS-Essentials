variable "cluster_name" {}
variable "tag" {
  default = "node-group-1"
}
variable "subnets_id" {}
variable "instance_type" {
  default  = "t3.small"
}
variable "node_name" {
    default = "private-node-group-1"
}

/*
variable "security_group_id" {
  
}
*/