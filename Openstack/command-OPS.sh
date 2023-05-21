yum install wget vim -y
wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
qemu-img convert -f qcow2 -O raw <file_image>.qcow2 <file_image>.raw

## Lệnh Upload Imagé
openstack image create "Image Cirros"  --file cirros-0.3.4-x86_64-disk.img --disk-format qcow2 --container-format bare --public
      
openstack image list


systemctl restart neutron-dhcp-agent neutron-openvswitch-agen neutron-l3-agent neutron-metadata-agent

## Lệnh Network RBAC
openstack network rbac create --target-project 7930955429e74b549a969cdab5e40675 --action access_as_shared --type subnetpool a0dc00c0-d365-435a-94ad-1fc73f5e16b2


