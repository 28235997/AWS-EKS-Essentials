
variable "cluster_name" {
   default = "public-endpoint-cluster"
}
variable "cluster_version" {
  default = "1.31"
}
variable "enis_subnet_ids" {}
variable "cluster_role_name" {
   default = "public-endpoint-cluster-role"
}