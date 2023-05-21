# Khởi tạo IKE policy
openstack vpn ike policy create --auth-algorithm sha512 --encryption-algorithm aes-256 --ike-version v1 --pfs group5 --lifetime units=seconds,value=3600 ikepolicy-pfsense

# Khởi tạo IPsec policy
openstack vpn ipsec policy create --auth-algorithm sha512 --encryption-algorithm aes-256 --encapsulation-mode tunnel --transform-protocol esp --lifetime units=seconds,value=3600 ipsecpolicy-pfsense

# Khởi tạo VPN Gateway trên router
openstack vpn service create --description "My VPN service" --router Router_vpn vnptoPfsense

# Khởi tạo endpoint khai báo local subnet trên OP
openstack vpn endpoint group create --type subnet --value sub-private178 --value sub_private1 my-local


# Khởi tạo endpoint khai báo remote peer phía site khách hàng
openstack vpn endpoint group create --type cidr --value 192.168.40.0/24 --value 192.168.10.0/24 my-pfsense

# Khởi tạo VPN connection
openstack vpn ipsec site connection create --vpnservice vnptoPfsense --ikepolicy ikepolicy-pfsense --ipsecpolicy ipsecpolicy-pfsense --peer-address 123.30.212.224 --peer-id 123.30.212.224 --local-endpoint-group my-local --peer-endpoint-group my-pfsense --psk secret --dpd action=restart --initiator bi-directional vpnconnectiontopfsense