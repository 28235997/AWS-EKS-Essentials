resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  node_group_name  = var.node_name
  node_role_arn   = aws_iam_role.nodes_assume_role_policy.arn
  subnet_ids = var.subnets_id
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    name = var.tag
  }
  depends_on = [ aws_iam_role_policy_attachment.amazon_eks_worker_node_policy ]
}
