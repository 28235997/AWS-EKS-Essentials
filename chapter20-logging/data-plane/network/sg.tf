
resource "aws_security_group_rule" "allow_default_http_port" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_node_port" {
  type              = "ingress"
  from_port         = 30020
  to_port           = 30020
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "allow_pod_port_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_8081" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "allow_default_http_8082" {
  type              = "ingress"
  from_port         = 8082
  to_port           = 8082
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "v_gateway_port" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "ssh_port" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_8080-egress" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_8082-egress" {
  type              = "egress"
  from_port         = 8082
  to_port           = 8082
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}
resource "aws_security_group_rule" "allow_pod_port_80-egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_8081-egress" {
  type              = "egress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_9901-egress" {
  type              = "egress"
  from_port         = 9901
  to_port           = 9901
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_9901-ingress" {
  type              = "ingress"
  from_port         = 9901
  to_port           = 9901
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}


resource "aws_security_group_rule" "allow_pod_port_443-egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}

resource "aws_security_group_rule" "allow_pod_port_443-ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = var.cluster_security_group_id
}
