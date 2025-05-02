
resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
   configuration_values = jsonencode({
     env = {
     ENABLE_PREFIX_DELEGATION = "true"
     WARM_PREFIX_TARGET = "1"
    } 
  })
    resolve_conflicts_on_create = "OVERWRITE"
     resolve_conflicts_on_update = "OVERWRITE"
  
}
resource "aws_eks_addon" "eks_kube_proxy_addon" {
  cluster_name = var.cluster_name
  addon_name   = "kube-proxy"   
  addon_version = "v1.31.0-eksbuild.2"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
 
}

resource "aws_eks_addon" "eks_pod-idenity_addon" {
  cluster_name = var.cluster_name
  addon_name   = "eks-pod-identity-agent"
}
