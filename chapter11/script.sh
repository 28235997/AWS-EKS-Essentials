#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl get sa -n kube-system
kubectl get cs or kubectl get componentstatus
kubectl describe services
kubectl get --raw='/readyz?verbose'
kubectl describe nodes
kubectl get --raw /metrics >metrics