#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
packer build eks-amazon-image-1.pkr.hcl
packer build filename


eksctl upgrade nodegroup \
  --name=private-node-group \
  --cluster=public-endpoint-cluster \
  --region=us-east-1


kubectl apply -f pod/deployment.yaml

 kubectl scale --replicas=3 -f pod/deployment.yaml

 kubectl taint nodes  ip-10-0-3-211.ec2.internal dedicated=special-user:NoSchedule

 kubectl cordon  ip-10-0-3-211.ec2.internal 

 #kubectl drain NODE --ignore-daemonsets=true


 kubectl drain  ip-10-0-3-211.ec2.internal  --ignore-daemonsets=true

#remove taint
kubectl taint nodes ip-10-0-3-211.ec2.internal dedicated:NoSchedule-
 or
kubectl taint nodes  ip-10-0-3-211.ec2.internal  dedicated-