resource "aws_eks_cluster" "public_endpoint_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_assume_role.arn
  version = var.cluster_version
  vpc_config {
    subnet_ids = concat(
      var.private_subnet_ids
    )
    endpoint_public_access  = "true"
  }
 
}
