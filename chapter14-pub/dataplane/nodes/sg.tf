
resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_group_id
}

resource "aws_security_group_rule" "nodeport" {
  type              = "ingress"
  from_port         = 30001
  to_port           = 30001
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_group_id
}


