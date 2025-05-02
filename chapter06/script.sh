#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
#get nodes
kubectl get nodes 