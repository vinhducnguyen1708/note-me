# Tạo profile
openstack cluster profile create --spec-file cr_basic.yml cr-server

# Khởi tạo Cluster
openstack cluster create --profile cr-server --desired-capacity 2 cr-server

# Xóa cluster
openstack cluster delete --force cr-server

# Xóa profile
openstack cluster profile delete --force  cr-server

# Xem thông tin cluster
openstack cluster show cr-server


# Khởi tạo senlin policy
openstack cluster policy create lb-policy --spec-file loadbalancer_policy.yaml

openstack cluster shrink cr-server
