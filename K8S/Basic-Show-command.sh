# Tạo pod dựa trên file Yaml
kubectl apply -f <file.yml>

# Su dung kubectl run tao pod bang lenh
kubectl run mosquito --image=nginx

kubectl get pod elephant -o yaml > elephant.yml
kubectl create deployment blue --image=nginx --replicas=3


kubectl run --restart=Never --image=busybox static-busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml


# kiểm tra trạng thái tất cả các pods
kubectl get pods -A
kubectl get pods -o wide




# Kiem tra trang thai cac node
kubectl get nodes -A
kubectl get pods --all-namespaces



kubectl get daemonsets -A
kubectl get daemonsets --all-namespaces
 
kubectl describe daemonset kube-flannel-ds --namespace=kube-system
# Kiểm tra pod theo lables
kubectl get all --selector env=prod,bu=finance,tier=frontend

# Xóa pod
kubectl delete pods --force <name>


# hiển thị trạng thái của namespace chỉ định, kube-system là namespace quản trị
kubectl get pods --namespace kube-system


# Describe một node
kubectl describe node <kubemaster> 


# Gắn tain cho node
kubectl tain nodes <node_name> app=blue:Noschedule

# Gan label cho node
kubectl label nodes <node_name> size=Large


kubectl certificate approve akshay
kubectl certificate deny agent-smith
kubectl delete csr agent-smith
kubectl get csr agent-smith -o yaml




