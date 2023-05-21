# Troubleshoot Ceph


## Lỗi báo not deep-scrubbed , scrub manual
ceph health detail | ag 'not deep-scrubbed since' | awk '{print $2}' | while read pg; do ceph pg deep-scrub $pg; done

ceph pg dump pgs | awk '{print $1" "$23}' | column -t


ceph osd pool ls detail