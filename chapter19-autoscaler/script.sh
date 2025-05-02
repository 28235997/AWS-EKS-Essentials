#!/bin/bash
echo "Setting enviroment for autoscaler\n********************************"
aws eks update-kubeconfig --name autoscaler-cluster 
ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
echo ${ACCOUNT_ID}
#minitor logs  kubectl -n kube-system logs -f deployment.apps/cluster-autoscaler