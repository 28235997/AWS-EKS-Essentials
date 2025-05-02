#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
kubectl get nodes
kubectl get sa  -n kube-system

export ACK_SYSTEM_NAMESPACE=ack-system \
export PROFILE=default   \
export AWS_REGION=us-east-1 \
export SERVICE=s3 \
export RELEASE_VERSION=$(curl -sL https://api.github.com/repos/aws-controllers-k8s/${SERVICE}-controller/releases/latest | jq -r '.tag_name | ltrimstr("v")')
aws ecr-public get-login-password --region $AWS_REGION --profile $PROFILE | helm registry login --username AWS --password-stdin public.ecr.aws

helm install --create-namespace -n $ACK_SYSTEM_NAMESPACE ack-$SERVICE-controller \ oci://public.ecr.aws/aws-controllers-k8s/$SERVICE-chart --version=$RELEASE_VERSION --set=aws.region=$AWS_REGION
kubectl --namespace ack-system get pods -l "app.kubernetes.io/instance=ack-s3-controller"