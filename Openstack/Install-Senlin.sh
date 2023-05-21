CREATE DATABASE senlin DEFAULT CHARACTER SET utf8;
GRANT ALL ON senlin.* TO 'senlin'@'192.168.10.91' \
  IDENTIFIED BY 'Welcome123';
GRANT ALL ON senlin.* TO 'senlin'@'%' \
  IDENTIFIED BY 'Welcome123';
  
openstack endpoint create senlin --region Hanoi \
  public http://192.168.10.91:8777
  
openstack endpoint create senlin --region Hanoi \
  internal http://192.168.10.91:8777

openstack endpoint create senlin --region Hanoi \
  admin http://192.168.10.91:8777
  
yum install -y openstack-senlin-engine openstack-senlin-api openstack-senlin-common openstack-senlin-conductor openstack-senlin-health-manager python3-senlinclient


[default]
debug = true
transport_url = rabbit://openstack:Welcome123@192.168.10.91:5672//openstack
[database]
connection = mysql+pymysql://senlin:Welcome123@192.168.10.91/senlin?charset=utf8

[keystone_authtoken]
service_token_roles_required = True
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = senlin
password = Welcome123
www_authenticate_uri = http://192.168.10.91:5000
auth_url = http://192.168.10.91:5000
memcached_servers = 192.168.10.91:11211

[senlin_api]
bind_host = 192.168.10.91
bind_port = 8777

[authentication]
auth_url = http://192.168.10.91:5000
service_username = senlin
service_password = Welcome123
service_project_name = service

[oslo_messaging_rabbit]
rabbit_userid = openstack
rabbit_hosts = 192.168.10.91
rabbit_password = Welcome123

[oslo_messaging_notifications]
driver = messaging
topics = stacklight_notifications