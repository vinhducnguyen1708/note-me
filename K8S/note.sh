#Filter node
#Rank node

#- Thành phần kubelet
#cài dạng service nằm trên các worker node, nhận các request 2 chiều. 

#Kube-proxy tạo ra các rule trên  để tạo ra traffic giữa các pod với nhau và ra ngoài external

#show all pod 
kubectl get pods -A


/etc/kubernetes/manifest/

#static pod được kubelet quản lý dưới dạng yaml

cat /var/lib/kubelet/

kubectl 
#label gắn vào đối tượng
#selector là lựa chọn đối tượng nếu muốn sử dụng
kubectl api-resource


#tạo pod trong một namespace





kubectl  rollout status 
#cơ chế straegy 


ps -ef | grep kube-api-server
kubectl -n kube-system logs  weave-net-g26x2 -c weave