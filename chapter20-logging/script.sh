 #!/bin/bash
CLUSTER_NAME="appmesh-cluster"
######################initialization ####################################
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export VPC_ID=$(aws ec2 describe-vpcs --filter "Name=tag:Name,Values=appmesh-cluster-vpc" --query 'Vpcs[].{id:VpcId}' --output text)
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region us-east-1

#download the iam policy file
#curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.10.0/docs/install/iam_policy.json

echo "create oidc provider"
echo "-------------------------------" 
eksctl utils associate-iam-oidc-provider \
      --region=us-east-1 \
      --cluster=${CLUSTER_NAME} --approve

##############################clean up ###################################################
rm crds.yaml
echo "delete sa "
echo "------------------------------------"
eksctl delete iamserviceaccount --cluster ${CLUSTER_NAME}  --name appmesh-controller-sa --namespace appmesh-system

echo "Delete envoy service account"
echo "------------------------------------"
eksctl delete iamserviceaccount --cluster ${CLUSTER_NAME} --name envoy-proxy-sa  --namespace appmesh-system

echo "Delete LB service account"
echo "-------------------------------"
  eksctl delete iamserviceaccount \
  --cluster=${CLUSTER_NAME} \
  --namespace=kube-system \
  --name=aws-load-balancer-controller-sa

echo "Delete app mesh sa in the namespace"
echo "------------------------------------"
helm delete appmesh-controller-sa -n appmesh-system

echo "Delete app controller in the namespace"
echo "------------------------------------"
helm delete appmesh-controller -n appmesh-system

kubectl delete ns appmesh-system

echo "uninstall LB"
echo "-------------------------------"
helm uninstall aws-load-balancer-controller aws-load-balancer-controller -n kube-system 

echo "Create the app mesh namespace"
echo "-------------------------------"
kubectl create ns appmesh-system

#stack

aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-kube-system-aws-load-balancer-controller-sa

aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-appmesh-system-envoy-proxy-sa

aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-appmesh-system-appmesh-controller-sa

############################################################################


#################service account ###########################################
echo "create appmesh controller sa with managed policy"
echo "-------------------------------"
eksctl create iamserviceaccount --cluster ${CLUSTER_NAME}  \
 --name appmesh-controller-sa \
 --attach-policy-arn arn:aws:iam::aws:policy/AWSAppMeshFullAccess \
 --override-existing-serviceaccounts --namespace appmesh-system \
 --approve

  eksctl create iamserviceaccount --cluster ${CLUSTER_NAME}  \
    --namespace kube-system \
    --name aws-load-balancer-controller-sa \
   --role-name AmazonEKSLoadBalancerControllerRole \
    --attach-policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy  \
    --override-existing-serviceaccounts \
    --approve
  
####################################################################

#######################################helm chat ##########################################
echo "add helm repo"
echo "----------------------------------------"
helm repo add eks https://aws.github.io/eks-charts

 helm upgrade -i appmesh-controller eks/appmesh-controller \
 --namespace appmesh-system \
 --set region=us-east-1 \
 --set serviceAccount.create=false \
 --set serviceAccount.name=appmesh-controller-sa 

#install controller
echo "Install load balancer CRDs:"
echo "--------------------------"
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"


helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=appmesh-cluster \
  --set region=us-east-1 \
  --set serviceAccount.create=false \
  --set vpcId="${VPC_ID}" \
  --set serviceAccount.name=aws-load-balancer-controller-sa 
  
wget https://raw.githubusercontent.com/aws/eks-charts/master/stable/aws-load-balancer-controller/crds/crds.yaml
kubectl apply -f crds.yaml
  #--set tracing.enabled=true \
 #--set tracing.provider=x-ray

########################################Load balancer ###########################################

echo "--------------output-----------------"
kubectl -n appmesh-system get all
kubectl -n kube-system get all
#kubectl get pod -A
#kubectl get sa aws-load-balancer-controller-sa -n kube-system -o yaml
kubectl get deployment -n kube-system aws-load-balancer-controller


#run this checks after app deployments
#kubectl get ingress
#kubectl logs -n kube-system   deployment.apps/aws-load-balancer-controller
#kubectl logs -n kube-system deployment.apps/aws-load-balancer-controller
#kubectl logs -n appmesh-system deployment.apps/appmesh-controller

#kubectl -n appmesh-system get all
#kubectl get crds | grep appmesh
 

