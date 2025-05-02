resource "aws_eks_cluster" "autoscaler_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster_role.arn
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  vpc_config {
    subnet_ids = concat(
      var.private_subnets_id
    )
  }
  tags = {
    "autoscaler.sh/discovery" = var.cluster_name
  }
  depends_on = [aws_iam_role_policy_attachment.amazon_eks_cluster_policy]
}

resource "aws_ec2_tag" "cluster_primary_security_group" {
  resource_id = aws_eks_cluster.autoscaler_cluster.vpc_config[0].cluster_security_group_id
  key         = "autoscaler.sh/discovery" 
  value       = var.cluster_name
}