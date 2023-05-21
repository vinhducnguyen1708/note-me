openstack volume type create ceph_baas
openstack volume type set ceph_baas --property volume_backend_name=ceph_baas

openstack volume type create ceph_ssd
openstack volume type set ceph_ssd --property volume_backend_name=ceph_ssd

openstack volume type create ceph_hdd
openstack volume type set ceph_hdd --property volume_backend_name=ceph_hdd