rpm -qa | grep kernel | sort
uname -r
grubby --info=ALL | grep ^kernel
grubby --default-kernel 
--set-default

