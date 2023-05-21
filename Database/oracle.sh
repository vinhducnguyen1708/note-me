#! /bin/bash

#=====CURRENT HOST CONFIGURATION=====
HOSTNAME=rac01
IP=10.194.11.105
SID=CDBRAC1
DOMAIN=vnptit3.vn


#=====BEGIN INSTALLATION=====
rm -rf /etc/hosts
cat > /etc/hosts <<EOF
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
::1 localhost localhost.localdomain localhost6 localhost6.localdomain6

$IP	$HOSTNAME.$DOMAIN
EOF
echo "INFO: CREATED HOSTS FILE [OK]"

rm -rf /etc/hostname
echo "$HOSTNAME.$DOMAIN" > /etc/hostname
echo "INFO: CONFIG HOSTNAME FILE [OK]"

rm -rf /etc/sysctl.d/98-oracle.conf
cat > /etc/sysctl.d/98-oracle.conf <<EOF
fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500
EOF

/sbin/sysctl -q -p /etc/sysctl.d/98-oracle.conf
echo "INFO: CONFIG SYSCTL [OK]"

rm -rf /etc/security/limits.d/oracle-database-preinstall-19c.conf
cat > /etc/security/limits.d/oracle-database-preinstall-19c.conf <<EOF
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728
EOF
echo "INFO: CONFIG LIMIT [OK]"

yum install -q -y xterm bc binutils compat-libcap1 compat-libstdc++-33 dtrace-utils elfutils-libelf elfutils-libelf-devel fontconfig-devel glibc glibc-devel ksh libaio libaio-devel libdtrace-ctf-devel libXrender libXrender-devel libX11 libXau libXi libXtst libgcc librdmacm-devel libstdc++ libstdc++-devel libxcb make net-tools nfs-utils python python-configshell python-rtslib python-six targetcli smartmontools sysstat unixODBC

userdel oracle
rm -rf /home/oracle
rm -rf /var/spool/mail/oracle

groupdel oinstall
groupdel dba
groupdel oper

groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper

useradd -u 54321 -g oinstall -G dba,oper oracle
echo "INFO: CREATE USER ORACLE [OK]"

sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/sysconfig/selinux
setenforce 0
echo "INFO: DISABLE SELINUX [OK]"

systemctl stop firewalld
systemctl disable firewalld
echo "INFO: DISABLE FIREWALL [OK]"


rm -rf /u01/app
mkdir -p /u01/app/oracle/product/19.3.0/dbhome_1
chown -R oracle:oinstall /u01
chmod -R 775 /u01
rm -rf /home/oracle/scripts
mkdir -p /home/oracle/scripts
echo "INFO: CREATED FOLDER [OK]"

cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=$HOSTNAME.$DOMAIN
export ORACLE_UNQNAME=$SID
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/19.3.0/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_SID=$SID

export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib

EOF

echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile

cat > /home/oracle/scripts/start_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh

export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbstart \$ORACLE_HOME
EOF

cat > /home/oracle/scripts/stop_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh

export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbshut \$ORACLE_HOME
EOF
echo "INFO: CREATE ENV FILE [OK]"

chown -R oracle:oinstall /home/oracle/scripts
chmod u+x /home/oracle/scripts/*.sh
reboot