
resource "aws_security_group_rule" "allow_default_http_port" {
  type              = "ingress"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "allow_pod_port_8080-egress" {
  type              = "egress"
  from_port         = "-1"
  to_port           = "-1"
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_80-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_443-egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_443-ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}
