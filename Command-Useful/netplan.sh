mv /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.nak


cat << EOF > /etc/netplan/50-cloud-init.yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 100
        eth1:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 102
        eth2:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 101
EOF

netplan apply

apt-get -y update && apt-get -y upgrade



cat << EOF > /etc/netplan/50-cloud-init.yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 100
        eth1:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 102
        eth2:
            dhcp4: true
            mtu: 1500
            dhcp4-overrides:
                route-metric: 101
            routes:
            - to: 10.10.44.0/24
              via: 10.10.43.1
EOF