mysql -e"SET GLOBAL innodb_max_dirty_pages_pct = 0;"   RESET MASTER;
RSYNCSTOTRY=7
cd /var/lib/mysql
X=0
while [ ${X} -lt ${RSYNCSTOTRY} ]
do
    X=`echo ${X}+1|bc`
    rsync -r * slaveserver:/var/lib/mysql/.
    sleep 60
done
mysql -e"FLUSH TABLES WITH READ LOCK; SELECT SLEEP(60);"

SLEEPID=`mysql -e"SHOW PROCESSLIST;" | grep "SELECT SLEEP(60)" | awk '{print $1}'`

mysql -e"KILL ${SLEEPID};"