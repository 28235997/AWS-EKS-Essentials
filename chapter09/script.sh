#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster
aws iam create-user –user-name alice
aws iam create-policy --policy-name <policy-name> --policy-document file://policy.json
aws iam attach-user-policy --policy-arn arn:aws:iam::ACCOUNTID:policy/eks-describe-policy --user-name alice
aws iam create-access-key --user-name alice
aws eks update-kubeconfig --name public-endpoint-cluster --profile alice
eksctl create iamidentitymapping \
--region us-east-1 \
--cluster public-endpoint-cluster \
--arn arn:aws:iam::ACCOUNTID:user/alice \
--group system:masters \
--no-duplicate-arns
kubectl create ns test-ns
eksctl create iamidentitymapping --cluster <cluster-name>
--region=eu-central-1 --arn arn:aws:iam::ACCOUNTID:role/myIAMrole
--group system:masters --username creatorAccount

##user map
  mapUsers: | 
    - userarn: arn:aws:iam::ACCOUNTID:user/alice
      username: alice
      groups:
        - system:masters
