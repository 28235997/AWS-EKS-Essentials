#run this on the bastion host
sudo apt update -y && \
sudo apt install python3-pip -y && \
pip3 install awscli --upgrade && \
sudo apt  install awscli -y && \
sudo snap install kubectl --classic

#configure this on the bastion
[joyce-credentials]
aws_access_key_id = <YOUR_AWS_ACCESS_KEY_ID>
aws_secret_access_key = >YOUR_AWS_SECRET_ACCESS_KEY>
[default]
role_arn = arn:aws:iam::ACCOUNTID:role/EKSClusterCreatorRole
source_profile = joyce-credentials  

#change cluster context
aws eks update-kubeconfig --name hybrid-endpoint-cluster
