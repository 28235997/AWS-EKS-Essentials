

#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl apply -f pod/deployment.yaml

 kubectl scale --replicas=3 -f pod/deployment.yaml

 kubectl taint nodes ip-10-0-4-100.ec2.internal  dedicated=for-special-pods:NoSchedule

 #kubectl drain NODE --ignore-daemonsets=true

 kubectl drain ip-10-0-4-100.ec2.internal  --ignore-daemonsets=true

#remove taint
kubectl taint nodes ip-10-0-3-211.ec2.internal dedicated:NoSchedule-
 or
#kubectl taint nodes  ip-10-0-3-211.ec2.internal  dedicated-
