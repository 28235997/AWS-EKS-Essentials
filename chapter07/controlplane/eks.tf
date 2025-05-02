resource "aws_eks_cluster" "public_endpoint_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  version = var.cluster_version
  vpc_config {
    subnet_ids = concat(
      var.enis_subnet_ids
    )
    endpoint_public_access  = "true"
  }
  depends_on = [aws_iam_role.cluster_role]
}