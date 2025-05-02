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
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = "true"
  }
  depends_on = [aws_iam_role.cluster_role]
}