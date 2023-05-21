# Disk in Linux

## Show partitions

df -Th

lsblk

## Show file's size in Linux

ls -l --block-size=M

## find largest file 

sudo du -a /dir/ | sort -n -r | head -n 20

sudo find / -type f -printf "%s\t%p\n" | sort -n | tail -10

## Mount thư mục
cat /etc/fstab
<source>  <dest>  <filesystem>    defaults        0 0

mount -a 

partprobe 

## Unmount thư mục
unmount <source>

