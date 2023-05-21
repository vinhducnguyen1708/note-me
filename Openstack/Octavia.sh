# Add key-pair

mkdir -p /etc/octavia/.ssh
ssh-keygen -b 2048 -t rsa -N "" -f /etc/octavia/.ssh/octavia
openstack keypair create --public-key /etc/octavia/.ssh/octavia.pub octavia

# Add Images into OpenStack
openstack image create --disk-format raw --container-format bare --private --tag amphora --file amphora-x64-haproxy.raw amphora-x64-haproxy

# Create Amphora Flavor
openstack flavor create --public m1.amphora --id 200 --vcpus 2 --ram 2048 --disk 8

##### TEST #####

openstack loadbalancer create --name loadbalancer-test --vip-subnet-id 8861364d-622c-4dc8-a79f-97cc05456ab3


openstack loadbalancer list

openstack loadbalancer listener create --name listener1 --protocol HTTP --protocol-port 80 loadbalancer-test

openstack loadbalancer pool create --name pool1 --lb-algorithm ROUND_ROBIN --listener listener1 --protocol HTTP

openstack loadbalancer member create --subnet-id 7f89fb5f-ec97-4ab1-a512-9335616a3830 --address 10.247.94.166 --protocol-port 80 pool1

mysql -u octavia -pWelcome123 -e "update octavia.load_balancer set provisioning_status = 'ACTIVE' where id = '2e2edb16-ed37-4855-870e-dffb144a56dc';"
update secrets set deleted = '1' where id ='57db4d44-b19e-4f35-9eb8-8fe62dbafb0e';






#### 

openssl genrsa -des3 -out server.key 2048

openssl req -new -key server.key -out server.csr

cp server.key server.key.org

openssl rsa -in server.key.org -out server.key

openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

openssl pkcs12 -export -in server.crt -inkey server.key -out test1.p12 -passout pass:


openstack secret store --name='tls_secret1' -t 'application/octet-stream' -e 'base64' --payload="$(base64 < test1.p12)"

secret_id=$(openstack secret list | awk '/ tls_secret1 / {print $2}')

openstack acl user add -u $(openstack user show octavia -c id -f value) $secret_id

openstack loadbalancer listener create --protocol-port 443 --protocol TERMINATED_HTTPS --name listener1 --default-tls-container=$secret_id lb1
