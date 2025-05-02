resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
  addon_version = "v1.18.5-eksbuild.1" 
   configuration_values = jsonencode({
     env = {
     ENABLE_PREFIX_DELEGATION = "true"
     WARM_PREFIX_TARGET = "1"
    }
  })
}