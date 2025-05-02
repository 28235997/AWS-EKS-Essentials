output "cluster_security_group_id" {
 value = aws_eks_cluster.autoscaler_cluster.vpc_config[0].cluster_security_group_id
}

output "cluster_name" {
  value = aws_eks_cluster.autoscaler_cluster.name
}

/*
output "cluater_role_arn" {
  value = aws_iam_role.cluster_role.arn
}
output "cluster_object" {
 value = aws_eks_cluster.autoscaler_cluster
}
output "cluster_endpoint" {
  value = aws_eks_cluster.autoscaler_cluster.endpoint
}
output "additional_security_group_ids" {
 value = aws_eks_cluster.autoscaler_cluster.vpc_config[0].security_group_ids
}
output "url" {
  value =  aws_eks_cluster.autoscaler_cluster.identity[0].oidc[0].issuer
}

output "cluster_ca" {
  value =   base64decode(aws_eks_cluster.autoscaler_cluster.certificate_authority[0].data)
}
*/