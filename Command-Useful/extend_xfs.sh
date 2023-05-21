CentOS 7:

ls /sys/class/scsi_device/
echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan

yum install cloud-utils-growpart

#!/bin/sh
id | grep root 1>/dev/null 2>&1
if test "$?" = "0"; then
   growpart /dev/sda 2 > /dev/null 2>&1
   pvresize /dev/sda2 > /dev/null 2>&1
   lvextend -l +100%FREE -r /dev/mapper/centos-root > resize.txt 2>&1; cat resize.txt | grep "GiB"
else
  echo
fi
---------------------------------
Ubuntu19:
#!/bin/sh
id | grep root 1>/dev/null 2>&1
if test "$?" = "0"; then
    growpart /dev/sda 3 > /dev/null 2>&1
    pvresize /dev/sda3 > /dev/null 2>&1
    lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv > resize.txt 2>&1; cat resize.txt | grep "GiB"
    resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv > /dev/null 2>&1
else
  echo
fi
---------------------------------
Ubuntu20-Desktop:
#!/bin/sh
id | grep root 1>/dev/null 2>&1
if test "$?" = "0"; then
  growpart /dev/sda 2 > /dev/null 2>&1
  growpart /dev/sda 5 > /dev/null 2>&1
  pvresize /dev/sda5 > /dev/null 2>&1
  lvextend -l +100%FREE /dev/mapper/vgubuntu-root > resize.txt 2>&1; cat resize.txt | grep "GiB"
  resize2fs /dev/mapper/vgubuntu-root > /dev/null 2>&1
else
  echo
fi
---------------------------------
Debian
apt install cloud-guest-utils -y

#!/bin/sh
id | grep root 1>/dev/null 2>&1
if test "$?" = "0"; then
    growpart /dev/sda 5 > /dev/null 2>&1
    pvresize /dev/sda5 > /dev/null 2>&1
    lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv > resize.txt 2>&1; cat resize.txt | grep "GiB"
    resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv > /dev/null 2>&1
else
  echo
fi
