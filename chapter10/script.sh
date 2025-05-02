#Update user context
aws eks update-kubeconfig --name public-endpoint-cluster

aws eks create-access-entry --cluster-name <CLUSTER_NAME> --principal-arn <IAM_PRINCIPAL_ARN>

aws eks associate-access-policy \
--cluster-name public-endpoint-cluster \
--principal-arn arn:aws:iam::ACCOUNTID:user/alice \
--policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy \
--access-scope type=cluster

aws eks associate-access-policy \
--cluster-name public-endpoint-cluster \
--principal-arn arn:aws:iam::ACCOUNTID:user/alice \
--policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy \
--access-scope type=cluster

aws eks disassociate-access-policy --cluster-name my-cluster --principal-arn arn:aws:iam::ACCOUNTID:user/alice \
    --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy


aws eks associate-access-policy \
--cluster-name public-endpoint-cluster \
--principal-arn  arn:aws:iam::ACCOUNTID:user/alice \
--policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy \
--access-scope type=cluster


aws eks list-associated-access-policies --cluster-name cluster-name \
 --principal-arn arn:aws:iam::ACCOUNTID:user/alice


