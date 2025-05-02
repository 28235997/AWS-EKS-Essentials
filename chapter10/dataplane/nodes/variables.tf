variable "cluster_name" {}
variable "tag" {
  default = "nodes"
}
variable "subnets_id" {}
variable "instance_type" {
  default  = "t3.small"
}
variable "node_name" {
    default = "private-node-group"
}
#variable "nodes_role_arn" {}
variable "security_group_id" {}