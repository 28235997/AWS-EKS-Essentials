#!/bin/bash
CLUSTER_NAME="istio-cluster"
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig \
   --name ${CLUSTER_NAME} \
   --region ${AWS_REGION}
kubectl create ns istio-system
istioctl install --set profile=demo -y
kubectl get pod -n istio-system