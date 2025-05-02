#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster

#check the oidc provider configuration
aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5
aws eks describe-cluster --name public-endpoint-cluster --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5
#find addon version
kubectl describe daemonset aws-node --namespace kube-system | grep amazon-k8s-cni: | cut -d : -f 3




