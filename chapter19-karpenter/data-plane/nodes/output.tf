
output "node_iam_role" {
  value =  aws_iam_role.karpenter_nodes_role.name
}
