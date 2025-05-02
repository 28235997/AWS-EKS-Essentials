data "aws_iam_policy_document" "assume_role" {
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

resource "aws_iam_role" "pod_identity_role" {
  name               = "pod-identity-vpc-lattice-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "vpc_lattice_gateway_controller_policy" {
  policy_arn = aws_iam_policy.vpc_lattice.arn
  role       = aws_iam_role.pod_identity_role.name
}

resource "aws_eks_pod_identity_association" "gateway_controller_sa" {
  cluster_name    = var.cluster_name
  namespace       = "aws-application-networking-system"
  service_account = "gateway-api-controller"
  role_arn        = aws_iam_role.pod_identity_role.arn
}