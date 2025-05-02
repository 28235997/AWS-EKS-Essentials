output "nodes_role_arn" {
  description = "policy out put."
  value       = aws_iam_role.nodes_assume_role_policy.arn
}
output "node_group_policy" {
  description = "node group output."
  value       = aws_iam_role.nodes_assume_role_policy.arn
}
output "worker_node_policy" {
  description = "policy out put."
  value       = aws_iam_role_policy_attachment.amazon_eks_worker_node_policy
}
output "eks_cni_policy" {
  description = "cni policy out put."
  value       =   aws_iam_role_policy_attachment.amazon_eks_cni_policy
}
output "container_registry_policy" {
  description = "container policy out put."
  value       =   aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only
}
  