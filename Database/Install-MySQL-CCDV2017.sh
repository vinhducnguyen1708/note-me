# Hướng dẫn cài đặt Database tương đồng với môi trường của hệ thống CCDV 2017

## Cài đặt repository và các phần mềm phụ trợ
apt -y update
apt install software-properties-common -y
add-apt-repository cloud-archive:mitaka -y
apt -y update
apt -y upgrade
apt -y dist-upgrade
apt -y install python-pip bc byobu telnet unzip

## Khởi động lại máy chủ
init 6

## Cài đặt Database
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu trusty main'
apt-get update
apt-get -y install mariadb-server python-mysqldb

## Giải nén file backup sql
mkdir backup-sql/
mv controller1.hn.vnpt_11022022-120001.sql.zip backup-sql/
cd backup-sql/
unzip controller1.hn.vnpt_11022022-120001.sql.zip

## Import bản Backup vào Database
mysql -u root -p < controller1.hn.vnpt_11022022-120001.sql

## Kiểm tra Import đã thành công
mysql -p -e 'show databases;'
mysql -p -e 'select user,host from mysql.user;'
mysql -p -e 'use keystone; select * from user;'

