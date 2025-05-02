
# Private Kubernetes node group
resource "aws_eks_node_group" "autoscaler_nodes" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = aws_iam_role.autoscaler_nodes_role.arn
  subnet_ids = var.private_subnets_id
  # node group type spot but you can use ON DEMAND
  capacity_type  = "ON_DEMAND"
  instance_types = var.instance_types
  #release_version
  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    "cluster-autoscaling-nodes"  = var.cluster_name
    "cluster-autoscaling" = "true"
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
  }
 depends_on = [aws_iam_role.autoscaler_nodes_role,
 aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
 aws_iam_role_policy_attachment.amazon_eks_cni_policy]

}
