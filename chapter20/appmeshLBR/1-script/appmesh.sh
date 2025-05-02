 #!/bin/bash
CLUSTER_NAME="appmesh-cluster"
######################initialization ####################################
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export VPC_ID=$(aws ec2 describe-vpcs --filter "Name=tag:Name,Values=appmesh-cluster-vpc" --query 'Vpcs[].{id:VpcId}' --output text)

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region ${AWS_REGION}

eksctl delete iamserviceaccount --cluster ${CLUSTER_NAME} \
  --name appmesh-controller-sa --namespace appmesh-system
eksctl delete iamserviceaccount --cluster ${CLUSTER_NAME} \
 --name aws-load-balancer-controller-sa --namespace kube-system

# Uninstall the existing Helm release
helm uninstall aws-load-balancer-controller --namespace kube-system
helm uninstall appmesh-controller --namespace appmesh-system

#delete namespace
kubectl delete ns appmesh-system

echo "create oidc provider"
echo "-------------------------------" 
eksctl utils associate-iam-oidc-provider \
      --region=${AWS_REGION} \
      --cluster=${CLUSTER_NAME} --approve

#create new namesapce
kubectl create ns appmesh-system

##############################clean up ###################################################

#stack
aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-appmesh-system-appmesh-controller-sa

aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller-sa

#################service account ###########################################
echo "create appmesh controller sa with managed policy"
echo "-------------------------------"
eksctl create iamserviceaccount --cluster ${CLUSTER_NAME}  \
 --name appmesh-controller-sa \
 --attach-policy-arn arn:aws:iam::aws:policy/AWSAppMeshFullAccess \
 --override-existing-serviceaccounts \
 --namespace appmesh-system \
 --approve

eksctl create iamserviceaccount --cluster ${CLUSTER_NAME}  \
    --namespace kube-system \
    --name aws-load-balancer-controller-sa \
   --role-name AmazonEKSLoadBalancerControllerRole \
    --attach-policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy  \
    --override-existing-serviceaccounts \
    --approve

#######################################helm chat ##########################################
echo "add helm repo"
echo "----------------------------------------"
helm repo add eks https://aws.github.io/eks-charts

 helm install appmesh-controller eks/appmesh-controller \
 --namespace appmesh-system \
 --set region=${AWS_REGION} \
 --set serviceAccount.create=false \
 --set serviceAccount.name=appmesh-controller-sa 

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=appmesh-cluster \
  --set region=${AWS_REGION} \
  --set serviceAccount.create=false \
  --set vpcId="${VPC_ID}" \
  --set serviceAccount.name=aws-load-balancer-controller-sa 

#install controller
#wget https://raw.githubusercontent.com/aws/eks-charts/master/stable/aws-load-balancer-controller/crds/crds.yaml
#kubectl apply -f crds.yaml

echo "--------------output-----------------"
kubectl get deployment -n kube-system aws-load-balancer-controller
kubectl -n appmesh-system get all