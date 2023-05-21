openstack network qos policy create bw-limiter-1Gbps
openstack network qos rule create --type bandwidth-limit --max-kbps 1000000 --egress bw-limiter-1Gbps
openstack network qos rule create --type bandwidth-limit --max-kbps 1000000 --ingress bw-limiter-1Gbps


openstack port set dacba57e-db51-48c0-a557-42ae59ac9ade --qos-policy 706d9d95-a5a8-4aad-ad41-6882be4eea94
