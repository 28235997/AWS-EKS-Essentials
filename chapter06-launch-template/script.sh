#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl scale deployment inflate --replicas 5



