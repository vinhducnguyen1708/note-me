cat << EOF > /etc/neutron/policy.json
{
    "context_is_admin":  "role:admin",
    "admin_or_owner": "rule:context_is_admin or rule:owner",
    "admin_or_network_owner": "rule:context_is_admin or tenant_id:%(network:tenant_id)s or field:networks:shared=True",
    "create_router:distributed": "rule:admin_or_owner",
    "get_router:distributed": "rule:admin_or_owner",
    "update_router": "rule:admin_or_owner",
    "update_router:external_gateway_info": "rule:admin_or_owner",
    "update_router:external_gateway_info:network_id": "rule:admin_or_owner",
    "update_router:distributed": "rule:admin_or_owner",
    "update_router:ha": "rule:admin_or_owner"
}
EOF

## Đường dẫn đổi icon Horizon
/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/img

## Tỉ lệ đang thiết lập trên OPS
cpu_allocation_ratio = 8.0
ram_allocation_ratio = 1.7

## Lỗi không cài được gói
dpkg --configure -a


## Xác thực SSL
cp /etc/kolla/certificates/ca/root.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

## Cấu hình docker engine để kết nối đến registry
cat << EOF > /etc/docker/daemon.json
{
    "bridge": "none",
    "ip-forward": false,
    "iptables": false,
    "insecure-registries": ["192.168.60.116:5000"],
    "log-opts": {
        "max-file": "5",
        "max-size": "50m"
    }
}
EOF


## Cấu hình pull image từ registry
    - openstack_release: "13.0.2"
    - kolla_base_distro: "ubuntu"
    - kolla_install_type: "source"
    - docker_namespace: "kolla/openstack.kolla"
    - docker_registry: "registry.cloudvnpt.com"
