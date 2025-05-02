 #!/bin/bash
CLUSTER_NAME="appmesh-cluster"
######################initialization ####################################
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region ${AWS_REGION}

echo "create oidc provider"
echo "-------------------------------" 
eksctl utils associate-iam-oidc-provider \
      --region=${AWS_REGION} \
      --cluster=${CLUSTER_NAME} --approve

##############################clean up ###################################################

kubectl delete ns appmesh-system

echo "delete sa "
echo "------------------------------------"
eksctl delete iamserviceaccount --cluster ${CLUSTER_NAME} \
 --name appmesh-controller-sa \
 --namespace appmesh-system

echo "Create the app mesh namespace"
echo "-------------------------------"
kubectl create ns appmesh-system

#stack
aws cloudformation delete-stack \
    --stack-name eksctl-appmesh-cluster-addon-iamserviceaccount-appmesh-system-appmesh-controller-sa

#################service account ###########################################
echo "create appmesh controller sa with managed policy"
echo "-------------------------------"
eksctl create iamserviceaccount --cluster ${CLUSTER_NAME}  \
 --name appmesh-controller-sa \
 --attach-policy-arn arn:aws:iam::aws:policy/AWSAppMeshFullAccess \
 --override-existing-serviceaccounts \
 --namespace appmesh-system \
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

echo "--------------output-----------------"
kubectl -n appmesh-system get all