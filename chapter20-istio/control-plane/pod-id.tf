/*
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

resource "aws_iam_role" "appmesh_pod_identity_role" {
  name               = "appmesh-pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.pod_id_policy.json
}

resource "aws_iam_role_policy_attachment" "appmesh_full_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshFullAccess"
  role       = aws_iam_role.appmesh_pod_identity_role.name
}

resource "aws_iam_role_policy_attachment" "appmesh" {
  policy_arn = aws_iam_policy.appmesh.arn
  role       = aws_iam_role.appmesh_pod_identity_role.name
}

resource "aws_iam_role_policy_attachment" "lb_for_appmesh" {
  policy_arn = aws_iam_policy.lbpolicy.arn
  role       = aws_iam_role.appmesh_pod_identity_role.name
}

resource "aws_eks_pod_identity_association" "appmesh_claim_id" {
  cluster_name    = var.cluster_name
  namespace       = "appmesh-system"
  service_account = "appmesh-controller-sa"
  role_arn        = aws_iam_role.appmesh_pod_identity_role.arn
   depends_on = [aws_eks_cluster.appmesh-cluster]
}

resource "aws_eks_pod_identity_association" "lb_claim_id" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller-sa"
  role_arn        = aws_iam_role.appmesh_pod_identity_role.arn
  depends_on = [aws_eks_cluster.appmesh-cluster]
}
*/