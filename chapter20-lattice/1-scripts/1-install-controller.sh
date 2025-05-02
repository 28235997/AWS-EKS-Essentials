 #!/bin/bash
CLUSTER_NAME="lattice-cluster"
######################initialization ####################################
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
export VPC_ID=$(aws ec2 describe-vpcs --filter "Name=tag:Name,Values=appmesh-cluster-vpc" --query 'Vpcs[].{id:VpcId}' --output text)

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region ${AWS_REGION}

kubectl delete ns aws-application-networking-system
#create namespaces
kubectl apply -f https://raw.githubusercontent.com/aws/aws-application-networking-k8s/main/files/controller-installation/deploy-namesystem.yaml

echo "authorize security groups"
CLUSTER_SG=$(aws eks describe-cluster --name $CLUSTER_NAME --output json| jq -r '.cluster.resourcesVpcConfig.clusterSecurityGroupId')
PREFIX_LIST_ID=$(aws ec2 describe-managed-prefix-lists --query "PrefixLists[?PrefixListName=="\'com.amazonaws.$AWS_REGION.vpc-lattice\'"].PrefixListId" | jq -r '.[]')
aws ec2 authorize-security-group-ingress --group-id $CLUSTER_SG --ip-permissions "PrefixListIds=[{PrefixListId=${PREFIX_LIST_ID}}],IpProtocol=-1"

echo "creating service account"
cat >gateway-api-controller-service-account.yml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
    name: gateway-api-controller
    namespace: aws-application-networking-system
EOF
kubectl apply -f gateway-api-controller-service-account.yml

# install vpc lattice gateway controller
aws ecr-public get-login-password --region us-east-1 | helm registry login \
 --username AWS \
 --password-stdin public.ecr.aws
helm install gateway-api-controller \
    oci://public.ecr.aws/aws-application-networking-k8s/aws-gateway-controller-chart \
    --version=v1.0.7 \
    --set=serviceAccount.create=false \
     --set serviceAccount.name=gateway-api-controller \
     --set role-name=pod-identity-vpc-lattice-role \
    --namespace aws-application-networking-system \
    --set=log.level=info 

echo "--------------output-----------------"
kubectl get deployment -n aws-application-networking-system
