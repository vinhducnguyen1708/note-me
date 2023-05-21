
yum install oracle-softwarecollection-release-el6

# Cấu hình repo addons 
cat << EOF > /etc/yum.repos.d/ol6-epel.repo
[ol6_epel]
name=Oracle Linux $releasever Latest ($basearch)
baseurl=https://yum.oracle.com/repo/OracleLinux/OL6/addons/x86_64
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
EOF

# http://mirror.neu.edu.cn/fedora-epel/6/x86_64/

dracu /boot/vmlinuz-2.6.32-754.el6.x86_64 2.6.32-754.el6.x86_64
dracut -f /boot/vmlinuz-2.6.32-754.35.1.el6.x86_64 2.6.32-754.35.1.el6.x86_64