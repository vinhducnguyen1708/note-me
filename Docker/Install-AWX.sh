yum -y install epel-release
yum -y update
yum -y install git wget vim python3-pip
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl disable --now firewalld
init 6
-------
yum -y install ansible

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
usermod -aG docker $(whoami)
systemctl daemon-reload
systemctl enable --now docker.service
iptables -P FORWARD ACCEPT
----
yum -y install rust cargo python3-devel libevent-devel openssl-devel gcc 
pip3 install setuptools-rust 
pip3 install wheel

pip3 install docker
pip3 install docker-compose

docker-compose --version

-----
cat <<EOF >>/etc/ssl/certs/awx.cnf
[req]
prompt = no
distinguished_name = req_distinguished_name
#req_extensions = v3_req

[req_distinguished_name]
countryName                     = VN
stateOrProvinceName             = HaNoi
localityName                    = Hanoi
0.organizationName              = Hocchudong
organizationalUnitName          = HCDcontent
commonName                      = 14.225.23.127
emailAddress                    = vinhducnguyen1708@gmail.com
EOF

openssl req -x509 -nodes -config /etc/ssl/certs/awx.cnf -days 3650 -newkey rsa:2048 -keyout /etc/ssl/certs/awx.key -out  /etc/ssl/certs/awx.crt
openssl rand -base64 30
-----
git clone https://github.com/ansible/awx.git
cd awx/
git checkout tags/17.1.0
mkdir -p /var/lib/awx/pgdocker
cd installer/
ansible-playbook -i inventory install.yml

