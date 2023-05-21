rbd -p volumes_hdd snap list volume-7dadc0a5-2476-4848-adb8-9bdd67776381


rbd children -a -p volumes_hdd  volume-7dadc0a5-2476-4848-adb8-9bdd67776381@snapshot-c747e568-9ae9-4844-8e24-4c251d67a88b


rados -p volumes_hdd listomapvals rbd_trash

rbd trash restore volumes_hdd/7687087d87bda6 --image trash_test

rados -p volumes_hdd listomapvals rbd_trash

rbd status volumes_hdd/trash_test

 # Watchers:     watcher=192.168.30.57:0/2445590874 client.4788 cookie=18446462598732840961
 
 
rbd rm volumes_hdd/trash_test