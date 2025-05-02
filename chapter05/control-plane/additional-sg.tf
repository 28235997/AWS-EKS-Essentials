resource "aws_security_group" "additional_security_group" {
 name   = "optional additional security group rules for ENIs"
 vpc_id = var.vpc_id
  egress {
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
 }
  egress {
  from_port         = 10250
  to_port           = 10250
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
 }
}

