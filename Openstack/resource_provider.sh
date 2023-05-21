
# Lệnh kiểm tra resource provier
openstack resource provider list

# Lệnh kiểm tra thông tin allocation
openstack allocation candidate list --resource VGPU=1

# Thiết lập tạo trait và gắn trait vào resource provider
openstack --os-placement-api-version 1.6 trait create CUSTOM_NVIDIA_232
openstack --os-placement-api-version 1.6 resource provider trait set --trait CUSTOM_NVIDIA_232 <resource provider>
openstack --os-placement-api-version 1.6 resource provider trait delete <resource provider>

# Lệnh gắn trait cho host aggregate
openstack --os-compute-api-version 2.53 aggregate set --property trait:CUSTOM_NVIDIA_232=required <host_aggregate>


# Lệnh thiết lập properties cho flavor sử dụng trait vGPU (bắt buộc phải có resource: vGPU)
openstack flavor set vgpu_1 --property "resources:VGPU=1"
openstack flavor set --property trait:CUSTOM_NVIDIA_232=required vgpu_1


# Cấu hình trong nova 
vim /etc/nova/nova.conf

[scheduler]
enable_isolated_aggregate_filtering = True

https://docs.openstack.org/nova/latest/user/flavors.html
https://docs.openstack.org/osc-placement/latest/cli/index.html
https://docs.openstack.org/nova/latest/reference/isolate-aggregates.html
https://specs.openstack.org/openstack/nova-specs/specs/train/implemented/placement-req-filter-forbidden-aggregates.html



# Khởi tạo resource provider
[1]https://docs.openstack.org/osc-placement/latest/user/index.html
[2] https://docs.openstack.org/osc-placement/latest/cli/index.html#cmdoption-openstack-allocation-candidate-list-group
[3]https://docs.openstack.org/nova/latest/user/flavors.html
