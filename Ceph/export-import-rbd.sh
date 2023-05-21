
rbd snap create volumes_hdd/volume-450186b2-dfb2-417c-879d-06c05619d0cd@volume-450186b2-dfb2-417c-879d-06c05619d0cd.snapshot

rbd export volumes_hdd/volume-450186b2-dfb2-417c-879d-06c05619d0cd@volume-450186b2-dfb2-417c-879d-06c05619d0cd.snapshot - | ssh root@192.168.30.41 "sudo rbd import --image-format 2 --image-feature layering,exclusive-lock,object-map,fast-diff,deep-flatten - volumes_ssd/volume-adm02-test"


rbd -p volumes_ssd remove volume-028cacf9-c265-4c5d-b88f-5bcfb8f7e818
rbd -p volumes_ssd rename volume-vinh-test volume-028cacf9-c265-4c5d-b88f-5bcfb8f7e818
