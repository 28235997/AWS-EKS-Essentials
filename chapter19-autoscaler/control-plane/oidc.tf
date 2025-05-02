
data "tls_certificate" "oidc" {
  url = aws_eks_cluster.autoscaler_cluster.identity[0].oidc[0].issuer
}
resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  url             =  data.tls_certificate.oidc.url
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
      type        = "Federated"
    }
  }  
}

#create controller role
resource "aws_iam_role" "autoscaler_controller_role" {
  name               = "ClusterAutoScalerRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  depends_on = [ data.tls_certificate.oidc]
}

#attach policy to the role

resource "aws_iam_role_policy_attachment" "cluster_auto_scaler" {
  policy_arn = aws_iam_policy.autoscaler_controller_policy.arn
  role       = aws_iam_role.autoscaler_controller_role.name
}

# Creating IAM Policy for auto-scaler
resource "aws_iam_policy" "autoscaler_controller_policy" {
  name = "cluster-autoscaler-policy"
  policy = jsonencode({
    
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:DescribeTags",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:GetInstanceTypesFromInstanceRequirements",
        "eks:DescribeNodegroup"
      ],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"      
      ],
      "Resource": ["*"]
    }
  ]

  })
}
