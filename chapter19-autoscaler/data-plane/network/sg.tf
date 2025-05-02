
resource "aws_security_group_rule" "https_port" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.security_group_id
}
resource "aws_security_group_rule" "dns_port" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.security_group_id
}

resource "aws_security_group_rule" "kubelet_port" {
  type              = "egress"
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.security_group_id 
}