#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl apply -f pod/deployment.yml 
kubectl get deployements
kubectl exec -it <DEPLOYMENT-NAME> sh
