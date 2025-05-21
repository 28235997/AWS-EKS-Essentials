resource "aws_eks_cluster" "public_endpoint_cluster" { #specifies the type of resource Terraform should create
# the aws_eks_clustercombines the resource provider’s name and resource type, the public_endpoint_clusteris the resource identifier
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster_role.arn
  #configure data plane subnets and eni
  vpc_config {
    subnet_ids = concat(
      var.private_subnet_ids
    )
    endpoint_public_access  = "true"
  }
  depends_on = [ aws_iam_role.cluster_role ]
}
