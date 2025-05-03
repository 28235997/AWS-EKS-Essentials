resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  node_group_name  = var.node_name
  node_role_arn   = aws_iam_role.nodes_assume_role_policy.arn
  subnet_ids = var.subnets_id
  capacity_type  = "SPOT" 
 launch_template {
   id =  aws_launch_template.on_spot_tp.id
   version = 1.0
}
 
  #ami_type = "AL2_ARM_64"
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  labels = {
    name = var.tag
  }
}
