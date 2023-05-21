# Tạo Host aggregate production và non-production
openstack aggregate create production
openstack aggregate create non-production

# Tạo availability zones và gán vào host aggregate
openstack aggregate set --zone production-az production
openstack aggregate set --zone non-production-az non-production

# Add Node compute vào host-aggregate
openstack aggregate add host production compute-0-4
openstack aggregate add host production compute-0-5
openstack aggregate add host production compute-0-6
openstack aggregate add host non-production compute-0-7
openstack aggregate add host non-production compute-0-8
openstack aggregate add host non-production compute-0-9


# Show info and set property
openstack aggregate show 4
openstack aggregate set 4 --property cpu_allocation_ratio='8.0'