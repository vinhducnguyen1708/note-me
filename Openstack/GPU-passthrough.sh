# Thực hiện enable SR-IOV
## Enable SR-IOV  trong grub
GRUB_CMDLINE_LINUX="intel_iommu=on"
## Rebuild lại file grub 
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
## Thực hiện reboot máy 
reboot
## Kiểm tra thông qua OS
dmesg | grep -i IOMMU
## Kiếm tra virt đã lấy được sriov hay chưa
virt-host-validate

# Cấu hình node compute cắm card GPU
## Kiểm tra card đã cắm ở node compute
lspci -nn | grep -i nvidia


## Kiểm tra PCI được lấy qua SR-IOV
ls -ld /sys/kernel/iommu_groups/*/devices/*af:00.?/


## Cấu hình nova compute, khai báo thông tin card đã cắm vào node compute
vim /etc/nova/nova.conf
#...
[pci]
passthrough_whitelist = [{"address": "0000:af:00.0"}]
alias = { "vendor_id":"10de", "product_id":"1eb8", "device_type":"type-PF", "name":"T4" }
#...

## Khởi động lại nova-compute
systemctl restart openstack-nova-compute

# Cấu hình trên các node controller
## Khai báo alias pci trên file cấu hình nova của các node controller để khi có request từ flavor có thể tìm được node compute nào khai báo sử dụng pci

vim /etc/nova/nova.conf
#...
[pci]
alias = { "vendor_id":"10de", "product_id":"1eb8", "device_type":"type-PF", "name":"T4" }
#...

## Khởi động lại nova-api và nova-scheduler
systemctl restart openstack-nova-api openstack-nova-scheduler

# Tạo flavor request GPU PCI
## Export biến môi trường Openstack
source admin-openrc
## Tạo flavor 
openstack flavor create --ram 4096 --disk 20 --vcpu 4 4C4R-GPU-passthrough
## Gắn metadata cho flavor 
openstack flavor set 4C4R-GPU-passthrough --property "pci_passthrough:alias"="T4:1"


