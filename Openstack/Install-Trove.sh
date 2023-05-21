CREATE DATABASE trove;

GRANT ALL PRIVILEGES ON trove.* TO 'trove'@'192.168.10.91' \
  IDENTIFIED BY 'Welcome123';
GRANT ALL PRIVILEGES ON trove.* TO 'trove'@'%' \
  IDENTIFIED BY 'Welcome123';
  
openstack user create --domain default --password Welcome123 trove

openstack role add --project service --user trove admin
  
openstack service create --name trove --description "Database" database

openstack endpoint create --region Hanoi \
  database public http://192.168.10.91:8779/v1.0/%\(tenant_id\)s

openstack endpoint create --region Hanoi \
  database internal http://192.168.10.91:8779/v1.0/%\(tenant_id\)s
   
openstack endpoint create --region Hanoi \
  database admin http://192.168.10.91:8779/v1.0/%\(tenant_id\)s
  
  
yum install openstack-trove python-troveclient openstack-trove-guestagent

https://opendev.org/openstack/trove/raw/branch/master/etc/trove/api-paste.ini