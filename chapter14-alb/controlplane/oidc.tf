

data "tls_certificate" "oidc" {
  url = aws_eks_cluster.public_endpoint_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_openid_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.oidc.url
}
data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc_openid_connect.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller-sa"]
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc_openid_connect.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "oidc_role" {
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
  name               = "MyAmazonEKSLoadBalancerControllerRole"
}



