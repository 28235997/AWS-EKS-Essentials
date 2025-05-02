
variable "ports" {
  description = "ports"
  type        = list(any)
  default     = [22]
}
variable "cidrBlocks" {
  description = "cidr blocks"
  type        = map(any)
  default = {
    internet = "0.0.0.0/0"
  }
}
variable "sshkey" {
  description = "ssh key"
  type        = string
  default     = "key"

}
variable "instance-type"{
  default = "t3.micro"
}
variable "instance-tags" {
  description = "instance tag"
  type        = map(any)
  default = {
    public  = "public-instance"
    private = "private-instance"
  }
}

variable "subnet_id" {}
variable "vpc_id" {}

variable "eports" {
  description = "ports"
  type        = list(any)
  default     = [0]
}
