# Unschedulelable one node
## This commnad will execute all pod from node01 to other node
kubectl drain <node_name> --ignore-daemonsets
## Configure the node to be unschedulelable
kubectl cordon <node_name>
## Configure the node node01 to be schedulable again.
kubectl uncordon <node_name>


# Upgrade node
apt update
apt search kubeadm
apt-cache show kubeadm | grep -i version
apt install kubeadm=1.20.0-00
## On master node 
kubeadm upgrade apply v1.20.0
## On worker node
kubeadm upgrade node
## upgrade kubelet
apt install kubelet=1.20.0-00
systemctl restart kubelet

# Check Version of the cluser
kubectl version --short

# Check the latest stable version
kubeadm upgrade plan

#### Backup and restore

# Backup all yaml file pod 
kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml

# Backup ETCD 
ETCDCTL_API=3 etcdctl snapshot save snapshot.db
ETCDCTL_API=3 etcdctl snapshot status snapshot.db
## Restore snapshot
service kube-apiserver stop
ETCDCTL_API=3 etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd-from-backup
systemctl daemon-reload
service etcd restart
service kube-apiserver start


ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db

ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db