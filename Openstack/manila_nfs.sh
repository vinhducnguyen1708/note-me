openstack share type create cephfstype false

openstack share type set cephfstype --extra-specs vendor_name=Ceph storage_protocol=NFS

openstack share type list


openstack share create --share-type cephfstype  --name cephnfsshare1  nfs 10


openstack share access list cephnfsshare1

openstack share access create  cephnfsshare1 ip 192.168.30.55
