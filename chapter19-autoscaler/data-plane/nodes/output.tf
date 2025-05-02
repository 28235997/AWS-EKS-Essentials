output "node_iam_role" {
  value =  aws_iam_role.autoscaler_nodes_role.name
}