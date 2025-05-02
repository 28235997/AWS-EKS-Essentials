resource "aws_eks_addon" "cloudwatch_addon" {
  addon_name   = "amazon-cloudwatch-observability"
  cluster_name = var.cluster_name
  depends_on = [aws_eks_cluster.appmesh-cluster]
}
