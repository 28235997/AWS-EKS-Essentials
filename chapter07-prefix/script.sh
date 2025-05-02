#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl apply -f pod/deployment.yml
kubectl get pods
kubectl scale deployment nginx-deployment --replicas 30
kubectl get pods