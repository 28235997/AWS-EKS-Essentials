
# Private Kubernetes node group
resource "aws_eks_node_group" "karpenter_nodes" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = aws_iam_role.karpenter_nodes_role.arn
launch_template {
  id = aws_launch_template.karpenter_tp.id
  version = "$Latest"
  }
  #aws_iam_role.karpenter_nodes_role.arn
  subnet_ids = var.private_subnets_id
  # node group type spot but you can use ON DEMAND
  capacity_type  = "ON_DEMAND"
  instance_types = var.instance_types
  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    "karpenter.sh/controller" = "true"
  }
  tags = {
    "karpenter.sh/discovery"  = var.cluster_name
  }
 
}
