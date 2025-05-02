/*
resource "aws_eks_addon" "eks_pod-idenity_addon" {
  cluster_name = var.cluster_name
  addon_name   = "eks-pod-identity-agent"
   depends_on = [aws_eks_cluster.appmesh-cluster]
}
*/