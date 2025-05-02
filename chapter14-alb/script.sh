 #!/bin/bash
CLUSTER_NAME="public-endpoint-cluster"
######################initialization ####################################
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export VPC_ID=$(aws ec2 describe-vpcs --filter "Name=tag:Name,Values=public-endpoint-cluster-vpc" --query 'Vpcs[].{id:VpcId}' --output text)

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region ${AWS_REGION}

echo "creating lb service account"
cat >lb-controller-service-account.yml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
    name: aws-load-balancer-controller-sa
    namespace: kube-system
EOF
kubectl apply -f lb-controller-service-account.yml

#######################################helm chat ##########################################
echo "add helm repo"
echo "----------------------------------------"
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=${CLUSTER_NAME} \
  --set region=${AWS_REGION} \
  --set serviceAccount.create=false \
  --set vpcId="${VPC_ID}" \
  --set serviceAccount.name=aws-load-balancer-controller-sa 

#update lb controller
echo "Install load balancer CRDs:"
echo "--------------------------"
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

echo "--------------output-----------------"
kubectl get deployment -n kube-system aws-load-balancer-controller
cat << EOF
rerun the kubectl get command again:
kubectl get deployment -n kube-system aws-load-balancer-controller 
EOF