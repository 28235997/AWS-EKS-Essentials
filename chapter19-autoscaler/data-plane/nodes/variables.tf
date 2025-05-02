
variable "cluster_name" {
}

variable "cluster_version" {
  default = "1.30"
}
variable "private_subnets_id" {}
variable "instance_types" {
  default  = ["t3.small"]
}

/*
variable "ami_id" {
  default = "ami-0000cd26924f513ba"
}

*/