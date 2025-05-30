
#necessary roles for worker nodes
resource "aws_iam_role" "worker_nodes_role" {
  name = "${var.cluster_name}-nodes"
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
#attach node role
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_nodes_role.name
}
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_nodes_role.name
}

# Optional, only if you want to "SSH" to your EKS nodes.
resource "aws_iam_role_policy_attachment" "amazon_ssm_managed_instance_core" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "appmesh" {
  policy_arn = aws_iam_policy.appmesh.arn
  role       = aws_iam_role.worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "aws_cloudwatch-agent" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "x-ray-agent" {
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
  role       = aws_iam_role.worker_nodes_role.name
}

