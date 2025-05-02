
variable "ports" {
  description = "ports"
  type        = list(any)
  default     = [111,2049,22]
}
variable "internet" {
    default  = "0.0.0.0/0"
  
}
variable "sshkey" {
  description = "ssh key"
  type        = string
  default     = "key"

}
variable "instance-type"{
  default = "t3.small"
}
variable "instance-tags" {
  default = "nfs-instance"
}

variable "subnet_id" {}
variable "vpc_id" {}

variable "eports" {
  description = "ports"
  type        = list(any)
  default     = [0]
}
