resource "aws_eks_cluster" "public_endpoint_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster_role.arn
  #configure public subnet for data plane subnets and eni
  vpc_config {
    subnet_ids = concat(
      var.public_subnet_ids
    )
    endpoint_public_access  = "true"
  }
  depends_on = [ aws_iam_role.cluster_role ]
}
