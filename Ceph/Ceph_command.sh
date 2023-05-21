## Các lệnh thực thi với CEPH 
https://github.com/nhanhoadocs/tutorial-ceph/blob/master/docs/operating/ceph-vs-openstack.md


### Dump crush map
ceph osd getcrushmap -o crushmapdump
crushtool -d crushmapdump -o crushmapdump-decompiled

#### Import Crush map
crushtool -c crushmapdump-decompiled -o crushmapdump-compiled
ceph osd setcrushmap -i crushmapdump-compiled

### đẩy object vào pool
rados -p foo put myobject blah.txt
rados -p foo rm myobject

### Thiết lập ratio
ceph osd set-full-ratio 0.97

### Hiển thị các crush class
ceph osd crush class ls

### Tạo crush class
ceph osd crush class create <crush_class>

### Xóa crush class
ceph osd crush class rm <crush_class>

### Tạo Crush rule
ceph osd crush rule create-replicated ceph_{{ item }} default host {{ item }}

### Hiển thị crush rule 
ceph osd crush rule ls

### Tao pool_name

ceph osd pool create volumes_hdd 64 64 replicated ceph_hdd 2


### Xóa pool <sẽ mất dữ liệu>
ceph osd pool delete <pool_name> <pool_name> --yes-i-really-really-mean-it

### Hiển thị các rbd trong pool
rbd -p vms ls
rbd ls <pool_name>
### Xem thông tin Pool
rbd -p backups info 

### Lệnh sử dụng xem trạng thái của CEPH
ceph -s 

### Lệnh sử dụng xem trạng thái và dung lượng các osd
ceph osd df

### Lệnh sử dụng xem dung lượng tổng quan của hệ thống
ceph df

### Xem cấu trúc OSD
ceph osd tree

### Hiển thị tất cả các PG hiện có <dùng để troubleshoot>
ceph pg dump

### Hiển thị các pool
ceph osd lspools

### Dump OSD info <có thể xem thông tin các pool và osd>
ceph osd dump 

#-----------Thiết lập bổ sung--------------#

### Thiết lập QoS cho rbd
rbd config image set volumes_hdd/volume-1e1a539c-4a24-4281-8392-811e323268f2 rbd_qos_iops_limit 30

#------------Thử nghiệm test-------------#

## Hướng dẫn khởi tạo rbd và mount vào ra ngoài để kiểm thử hiệu năng

rbd create foo --size 4096 -p <pool_name>

rbd map foo -p <pool_name>

mkfs.ext4 /dev/rbd0

mkdir /test-rbd

mount /dev/rbd0 /test-rbd


### Gỡ bỏ
umount /dev/rbd0 /test-rbd

rbd unmap foo -p <pool_name>

rbd remove foo -p <pool_name>

rm -rf /test-rbd 
## Thiết lập lại PG cho pool sẽ ghép vào

ceph osd pool set <pool_name> pg_num <new-number>

## Thiết lập lại PG cho pool backups

ceph osd pool set backups pg_num <new-number>

## chuyển crush_rule cho pool backups

ceph osd pool set backups crush_rule <pool_name>



ceph mgr module enable dashboard

ceph mgr module disable dashboard

ceph mgr module ls


### Hien thi config cua 1 the

ceph config get mon

https://yjwang.tistory.com/123

https://access.redhat.com/solutions/5215611

