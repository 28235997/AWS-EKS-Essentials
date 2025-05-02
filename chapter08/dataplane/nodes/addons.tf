resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
  #addon_version = "v1.18.5-eksbuild.1" 
   configuration_values = jsonencode({
     env = {
     ENABLE_PREFIX_DELEGATION = "true"
     WARM_PREFIX_TARGET = "1"
    }
  })
}

resource "aws_eks_addon" "eks_kube_proxy_addon" {
 cluster_name =  var.cluster_name
  addon_name   = "kube-proxy"
 # addon_version =  "v1.31.0-eksbuild.5" 
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}
