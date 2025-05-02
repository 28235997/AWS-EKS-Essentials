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

resource "aws_iam_role" "pod_identity_role" {
  name               = "pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.pod_id_policy.json
}

resource "aws_iam_role_policy_attachment" "secret_manager_policy" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.pod_identity_role.name
}


resource "aws_iam_role_policy_attachment" "s3_bucket_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.pod_identity_role.name
}

resource "aws_eks_pod_identity_association" "pod_identity_claim_id" {
  cluster_name    = var.cluster_name
  namespace       = "default"
  service_account = "pod-service-account"
  role_arn        = aws_iam_role.pod_identity_role.arn
}

