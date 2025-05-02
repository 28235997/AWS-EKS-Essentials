
#!/bin/bash

echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig --name public-endpoint-cluster

aws s3api create-bucket \
--bucket <YOUR_BUCKET_NAME> \
--region <AWS_REGION>

aws ecr create-repository \
    --repository-name docker-images \
    --region <AWS_REGION> \
    --tags '[{"Key":"env","Value":"test"},{"Key":"team","Value":"DevOps"}]'
    
aws secretsmanager create-secret \
--name app-secret-1 \
--description "test app secret" \
--secret-string '{"SECRET":"SuperSecret"}' \
--region <AWS_REGION>
