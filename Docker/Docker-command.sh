## Cài đặt docker-ce
sudo yum install epel-release
yum -y update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo usermod -aG docker $(whoami)
sudo systemctl enable --now docker.service


iptables -P FORWARD ACCEPT
## Trouble shoot khi không start được docker ( thường là do chưa cài đặt iptables )
yum remove podman buildah

sudo dockerd -D

### Cài đặt Iptables
yum -y install iptables


## Cài đặt docker-compose
pip3 install cffi
yum -y install rust cargo python3-devel libevent-devel openssl-devel gcc 
pip3 install setuptools-rust
pip3 install wheel

pip3 install docker
pip3 install docker-compose

