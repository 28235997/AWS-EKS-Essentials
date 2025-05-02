
resource "aws_iam_role" "autoscaler_nodes_role" {
  name = "AutoScalerNodeRole-${var.cluster_name}"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.autoscaler_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.autoscaler_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.autoscaler_nodes_role.name
}

# Optional, only if you want to "SSH" to your EKS nodes.
resource "aws_iam_role_policy_attachment" "amazon_ssm_managed_instance_core" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.autoscaler_nodes_role.name
}

resource "aws_iam_instance_profile" "autoscaler_instance_profile" {
  name = "ClusterAutoScalerNodeInstanceProfile-${var.cluster_name}"
  role = aws_iam_role.autoscaler_nodes_role.name
}

