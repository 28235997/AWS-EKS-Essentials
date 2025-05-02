#!/bin/bash

#kubectl apply -f https://raw.githubusercontent.com/aws/aws-application-networking-k8s/main/files/controller-installation/gatewayclass.yaml

export CLUSTER_NAME="lattice-cluster"
aws vpc-lattice create-service-network --name color-app-vpc-lattice-network
SERVICE_NETWORK_ID=$(aws vpc-lattice list-service-networks --query "items[?name=="\'color-app-vpc-lattice-network\'"].id" | jq -r '.[]')
CLUSTER_VPC_ID=$(aws eks describe-cluster --name $CLUSTER_NAME | jq -r .cluster.resourcesVpcConfig.vpcId)
aws vpc-lattice create-service-network-vpc-association --service-network-identifier $SERVICE_NETWORK_ID --vpc-identifier $CLUSTER_VPC_ID

aws vpc-lattice list-service-network-vpc-associations --vpc-id $CLUSTER_VPC_ID
