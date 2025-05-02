resource "aws_security_group" "sg" {
  name   = "bastion-sg"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.internet]
    }
  }
  #outboud rule for updates and other outbound traffic
  dynamic "egress" {
    for_each = var.eports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = -1
      cidr_blocks = [var.internet]
    }
  }
  
}