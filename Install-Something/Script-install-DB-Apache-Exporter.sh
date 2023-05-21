apt-get -y update
apt-get -y install expect
apt-get -y install mysql-server
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql restart 
echo "Set MYSQL password"
SECURE_MYSQL=$(expect -c "
set timeout 3
spawn mysql_secure_installation
expect \"New password:\"
send \"Welcome123\r\"
expect \"Re-enter new password:\"
send \"Welcome123\r\"
expect \"Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) :\"
send \"Y\r\"
expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"Y\r\"
expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"Y\r\"
expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"Y\r\"
expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"Y\r\"
expect eof
")



cat << EOF | mysql -uroot 
CREATE DATABASE wpdb;
GRANT ALL PRIVILEGES ON wpdb.* TO "wpuser"@"%" IDENTIFIED BY "wppass"; 
FLUSH PRIVILEGES;
EXIT
EOF
---------------------------------------------------------------------------------
apt update && apt upgrade -y
apt install -y apache2  php
apt install -y php libapache2-mod-php php-cli unzip php-fpm php-json php-pdo php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath


cat << EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
<Directory /var/www/html>
        AllowOverride All
</Directory>
</VirtualHost>
EOF

cat << EOF > /etc/apache2/mods-enabled/dir.conf
<IfModule mod_dir.c>
        DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
EOF

systemctl is-enabled apache2
systemctl reload apache2
systemctl restart apache2


cd /var/www/html
wget -c http://wordpress.org/latest.zip
unzip latest.zip

apt update && sudo apt -y upgrade
mv /var/www/html/wordpress/* /var/www/html/
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/wpdb/" /var/www/html/wp-config.php
sed -i "s/username_here/wpuser/" /var/www/html/wp-config.php
sed -i "s/password_here/wppass/" /var/www/html/wp-config.php
sed -i "s/localhost/192.168.20.247/" /var/www/html/wp-config.php

service apache2 reload

------------------------------------------------------------------------
cat << EOF > /lib/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Type=simple
ExecStart=/opt/prometheus/node_exporter

[Install]
WantedBy=multi-user.target
EOF



chown root:root /lib/systemd/system/node_exporter.service

grep prometheus /etc/passwd > /dev/null || useradd -d /opt/prometheus -m prometheus
cd /opt/prometheus
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xf node_exporter-0.18.1.linux-amd64.tar.gz --strip 1
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter