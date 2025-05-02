
output "cluster_name" {
  value = aws_eks_cluster.public_endpoint_cluster.name
}
output "cluster_security_group_id" {
  value = aws_eks_cluster.public_endpoint_cluster.vpc_config[0].cluster_security_group_id
}
output "cluster_vpc" {
  value = aws_eks_cluster.public_endpoint_cluster
}
output "vpc_id" {
  value = aws_eks_cluster.public_endpoint_cluster.vpc_config[0].vpc_id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.public_endpoint_cluster.endpoint
}

output "cluster_auth" {
  value = aws_eks_cluster.public_endpoint_cluster.certificate_authority[0].data
}

output "ca" {
  value = aws_eks_cluster.public_endpoint_cluster.certificate_authority
}

