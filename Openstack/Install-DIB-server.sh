# Cài đặt máy chủ DIB để đóng gói Images

#Cài đặt trên máy chủ Ubuntu1804

## Cài đặt các gói cần thiết

sudo apt-get install software-properties-common
sudo apt-add-repository universe
sudo apt-get update
sudo apt-get -y install python-pip


# Cài đặt KVM

sudo apt install -y qemu qemu-kvm libvirt-bin  bridge-utils  virt-manager
apt-get install -y qemu-user-static
apt-get -y install qemu-utils git kpartx debootstrap
sudo apt-get -y install alien
apt-get -y install yum-utils
apt install libguestfs-tools

pip install setuptools
pip install wheel


guestfish -a ubuntu-20.04.3-LTS.x86.64.qcow2
