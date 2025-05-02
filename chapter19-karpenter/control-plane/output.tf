output "cluster_security_group_id" {
 value = aws_eks_cluster.karpenter_cluster.vpc_config[0].cluster_security_group_id
}

output "cluster_name" {
  value = aws_eks_cluster.karpenter_cluster.name
}

output "sa_role_arn" {
  value = aws_iam_role.karpenter_controller_role.arn
}

output "karpenter_policy" {
  value = aws_iam_policy.karpenter_controller_policy.arn
}
