#!/bin/bash

# Khai bao dinh dang ngay-thang-nam thuc hien backup
ngay=`eval date +%d%m%Y-%H%M%S`
nameSRV=`hostname`
MatKhau=`openssl rand -hex 10`
Nhieu1=`openssl rand -hex 2`
Nhieu2=`openssl rand -hex 3`

# Khai bao thu muc chua file backup va thu muc chua mat khau giai nen file backup
ThuMuc1="/var/backup/mysql/"
ThuMuc2="/var/MYSQLpass/"
filepass=""$ThuMuc2""$nameSRV""_""$ngay""_""pass_mysql".txt"

# Khoi tao thu muc chua file backup va file chua mat khau nen
echo "Create folder backup"
if ! [ -d $ThuMuc1 ]
then
mkdir -p $ThuMuc1
fi

if ! [ -d $ThuMuc2 ]
then
mkdir -p $ThuMuc2
fi

# Kiem tra goi zip da duoc cai dat chua
pack1="/var/cache/apt/archives/zip*"
if ! [ -f $pack1 ]
then
echo "Cai dat goi zip"
sudo yum install zip -y
fi

# Thuc hien backup MySQL database
echo "V"$Nhieu1"D"$MatKhau"C"$Nhieu2 >> $filepass
mysqldump --opt -u root  --all-databases > $ThuMuc1"$nameSRV""_""$ngay".sql

# Thuc hien nen và dat mat khau cho file backup
cd $ThuMuc1
zip -P $MatKhau "$nameSRV""_""$ngay".sql.zip "$nameSRV""_""$ngay".sql
sleep 10

# Go bo file backup goc, chi giu lai file nen

rm -f "$nameSRV""_""$ngay".sql
sleep 10

# Go bo cac ban backup da ton tai hon 7 ngay
find $ThuMuc1 -ctime 7 -type f -delete
