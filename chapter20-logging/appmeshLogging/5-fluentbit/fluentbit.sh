 #!/bin/bash
CLUSTER_NAME="appmesh-cluster"
######################initialization ####################################
export AWS_REGION=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

kubectl create ns amazon-cloudwatch

ClusterName=$CLUSTER_NAME
RegionName=$AWS_REGION
FluentBitHttpPort='2020'
FluentBitReadFromHead='Off'
[[ ${FluentBitReadFromHead} = 'On' ]] && FluentBitReadFromTail='Off'|| FluentBitReadFromTail='On'
[[ -z ${FluentBitHttpPort} ]] && FluentBitHttpServer='Off' || FluentBitHttpServer='On'

kubectl create configmap fluent-bit-cluster-info \
 --from-literal=cluster.name=${ClusterName} \
 --from-literal=http.server=${FluentBitHttpServer} \
 --from-literal=http.port=${FluentBitHttpPort} \
 --from-literal=read.head=${FluentBitReadFromHead} \
 --from-literal=read.tail=${FluentBitReadFromTail} \
 --from-literal=logs.region=${RegionName} -n amazon-cloudwatch

kubectl apply -f https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/fluent-bit/fluent-bit.yaml

kubectl get pods -n amazon-cloudwatch