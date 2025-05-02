resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  node_group_name  = var.node_name
  node_role_arn   =  aws_iam_role.worker_nodes_role.arn
  subnet_ids = var.subnet_ids
  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND" 
launch_template {
  id = aws_launch_template.launch_template.id
  version = "$Latest"
}

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    name = var.label
  }
  tags = {
    Name = "worker-node"
  }
  depends_on = [ aws_iam_role.worker_nodes_role ]
}


