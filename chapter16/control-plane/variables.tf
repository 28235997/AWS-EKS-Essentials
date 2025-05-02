
variable "cluster_name" {
   default = "public-endpoint-cluster"
}
variable "cluster_version" {
  default = "1.31"
}
variable "eni_subnet_ids" {}
variable "vpc_id" {}