resource "aws_eks_cluster" "private_endpoint_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster_role.arn
  #configure data plane subnets and eni
  vpc_config {
   security_group_ids  = [aws_security_group.additional_security_group.id]
    subnet_ids = concat(
      var.eni_subnet_ids
    )
    endpoint_private_access = "true"
    endpoint_public_access  = "false"
  }
  depends_on = [ aws_iam_role.cluster_role ]
}
