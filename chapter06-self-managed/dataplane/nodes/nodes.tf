resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  node_group_name  = var.node_name
  node_role_arn   = aws_iam_role.nodes_role.arn
  subnet_ids = var.subnets_id
  capacity_type  = "ON_DEMAND" 
  instance_types = ["t3.small"]

  launch_template {
  id = aws_launch_template.launch_template.id
  version = "$Latest"
  }
/*
taint {
   key    = "statefulset-no-schedule"
   value  = "true"
   effect = "NO_SCHEDULE"
}
*/

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    name = var.tag
  }
  depends_on = [ aws_iam_role.nodes_role]
}