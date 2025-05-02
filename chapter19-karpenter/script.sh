#!/bin/bash
CLUSTER_NAME=karpenter-cluster
KARPENTER_VERSION=1.1.1
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
CLUSTER_ENDPOINT=$(aws eks describe-cluster --name karpenter-cluster --query "cluster.endpoint" --output text)
SERVICE_ACCOUNT=KarpenterControllerRole-karpenter-cluster
aws eks update-kubeconfig --name karpenter-cluster && kubectl create ns karpenter
echo "add helm repo"
echo "----------------------------------------"
helm repo add eks https://aws.github.io/eks-charts
echo "installing karpenter\n********************************"
docker logout public.ecr.aws

helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter --version ${KARPENTER_VERSION} \
 --namespace karpenter  \
  --set "settings.clusterName=${CLUSTER_NAME}" \
  --set clusterEndpoint=${CLUSTER_ENDPOINT} \
  --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"="arn:aws:iam::${ACCOUNT_ID}:role/${SERVICE_ACCOUNT}" \
  --set controller.resources.requests.cpu=1 \
  --set controller.resources.requests.memory=1Gi \
  --set controller.resources.limits.cpu=1 \
  --set controller.resources.limits.memory=1Gi \
  --set logLevel=debug \
  --wait