variable "cluster_name" {}
variable "tag" {
  default = "managed-nodes"
}
variable "subnets_id" {}
variable "instance_type" {
  default  = "t3.small"
}
variable "node_name" {
    default = "private-managed-node-group"
}
variable "security_group_id" {}