auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet manual
  up ifconfig $IFACE 0.0.0.0 up
  up ip link set $IFACE promisc on
  down ip link set $IFACE promisc off
  down ifconfig $IFACE down

auto br-ex
iface br-ex inet static
  address 10.168.3.201
  netmask 255.255.255.0

cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto enp1s0
  iface enp1s0 inet static
  address 192.168.60.112
  netmask 255.255.255.0
  gateway 192.168.60.1
  dns-nameservers 8.8.8.8 8.8.4.4

auto enp9s0
  iface enp9s0 inet static
  address 10.10.1.112
  netmask 255.255.255.0

auto enp10s0
  iface enp10s0 inet static
  address 10.10.2.112
  netmask 255.255.255.0
EOF


cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto enp2s0
  iface enp2s0 inet static
  address 192.168.60.106
  netmask 255.255.255.0
  gateway 192.168.60.1
  dns-nameservers 8.8.8.8 8.8.4.4
 
auto enp1s0
iface enp1s0 inet manual
  up ifconfig $IFACE 0.0.0.0 up
  up ip link set $IFACE promisc on
  down ip link set $IFACE promisc off
  down ifconfig $IFACE down

auto br-ex
iface br-ex inet static
  address 192.168.50.106
  netmask 255.255.255.0

auto enp10s0
  iface enp10s0 inet static
  address 10.10.1.106
  netmask 255.255.255.0
EOF

cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto enp2s0
  iface enp2s0 inet static
  address 192.168.60.105
  netmask 255.255.255.0
  gateway 192.168.60.1
  dns-nameservers 8.8.8.8 8.8.4.4

auto enp1s0
iface enp1s0 inet manual
  up ifconfig $IFACE 0.0.0.0 up
  up ip link set $IFACE promisc on
  down ip link set $IFACE promisc off
  down ifconfig $IFACE down

auto br-ex
iface br-ex inet static
  address 192.168.50.105
  netmask 255.255.255.0
EOF


systemctl restart networking




cat << EOF > /etc/network/interfaces
allow-br-ex eth1
iface eth1 inet manual
  ovs_bridge br-ex
  ovs_type OVSPort

auto br-ex
allow-ovs br-ex
iface br-ex inet manual
  ovs_type OVSBridge
  ovs_ports eth1
EOF

ifdown --force -vvv <iface>
ip address flush dev <iface>
ip link set <iface> down
ifup -vvv <iface>