
data "aws_iam_policy_document" "pod_id_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

#create controller role
resource "aws_iam_role" "karpenter_controller_role" {
  name               = "KarpenterControllerRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.pod_id_policy.json
}

#attach policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy_to_karpenter_controller_role" {
  policy_arn = aws_iam_policy.karpenter_controller_policy.arn
  role       = aws_iam_role.karpenter_controller_role.name
  depends_on = [ aws_iam_policy.karpenter_controller_policy ]
}

resource "aws_eks_pod_identity_association" "pod_identity_claim_id" {
  cluster_name    = var.cluster_name
  namespace       = "karpenter"
  service_account = "karpenter"
  role_arn        = aws_iam_role.karpenter_controller_role.arn
  depends_on = [ aws_eks_cluster.karpenter_cluster ]
}
