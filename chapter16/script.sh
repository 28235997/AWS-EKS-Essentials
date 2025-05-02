#MAKE SURE YOU REPLACE IP ADDRESS WITH YOUR NETWORK IPs
#change cluster context
aws eks update-kubeconfig --name public-endpoint-cluster

#install driver
curl -skSL https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/v4.5.0/deploy/install-driver.sh | bash -s v4.5.0 --
kubectl -n kube-system get pod -o wide -l app=csi-nfs-controller
kubectl -n kube-system get pod -o wide -l app=csi-nfs-node

https://www.kubernet.dev/troubleshooting-pvc-pending-error-in-kubernetes-a-complete-guide/

nfs installation

https://medium.com/@manankathrecha/how-to-install-and-configure-an-nfs-server-on-ubuntu-59472f644403

sudo ufw allow from 10.0.0.0/24 to any port nfs

 sudo mount 10.0.5.56:/mnt/nfs_share  /mnt/nfs_clientshare

sudo mount -t nfs 10.0.5.56:/mnt/nfs_share  /mnt/nfs_clientshare
df -hT /tmp/test

install nfs
https://www.itwonderlab.com/kubernetes-nfs/

gp2 
 kubernetes.io/aws-ebs  
 systemctl start rpcbind
systemctl enable rpcbind

sudo nano /etc/exports
/var/nfs/application node1.node1.node1.node1(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/application node2.node2.node2.node2(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/database node1.node1.node1.node1(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/database node2.node2.node2.node2(rw,sync,no_root_squash,no_subtree_check)


/var/nfs/application 10.0.3.148(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/application 10.0.4.19(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/database 10.0.3.148(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/database 10.0.4.19(rw,sync,no_root_squash,no_subtree_check)


/var/nfs/application 10.0.4.130(rw,sync,no_root_squash,no_subtree_check)
/var/nfs/database 10.0.4.130(rw,sync,no_root_squash,no_subtree_check)

sudo exportfs -rav
sudo systemctl enable --now nfs-server
sudo exportfs -ar

https://kubedemy.io/kubernetes-storage-part-1-nfs-complete-tutorial

/etc/hosts
nfs.nfs.nfs.nfs pv-nfs


###########
sudo apt update && apt -y upgrade
sudo apt install -y nfs-server
mkdir /data
sudo cat <<EOF >> /etc/exports
/data 10.0.3.36(rw,no_subtree_check,no_root_squash)

sudo systemctl enable --now nfs-server
sudo exportfs -ar
sudo apt install -y nfs-common

EOF



 sudo apt update && apt -y upgrade
 sudo apt install -y nfs-server
 sudo mkdir /data

cat <<EOF >> /etc/exports
/data 10.0.0.18(rw,no_subtree_check,no_root_squash)
sudo systemctl enable --now nfs-server
sudo exportfs -ar
sudo apt install -y nfs-common


kubectl apply -f nfs-pvc.yaml
kubectl get persistentvolumeclaims
kubectl describe pvc pvc-nfs-dynamic


kubectl apply -f nfs-sc.yaml
kubectl get storageclasses
kubectl describe storageclasses nfs-csi

kubectl describe pod nginx-nfs

sudo apt update && apt -y upgrade

sudo apt install -y nfs-server
sudo systemctl enable --now nfs-server
sudo exportfs -ar
sudo apt install -y nfs-common
