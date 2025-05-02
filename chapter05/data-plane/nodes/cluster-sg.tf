#inbound call from the bastion host to the cluster
resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

#outbound call to the internet
resource "aws_security_group_rule" "https_port" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}
