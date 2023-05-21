# Xử lý lỗi provisioning_status của LB luôn treo trạng thái PENDING_UPDATE
mysql -u octavia -pWelcome123 -e "update octavia.load_balancer set provisioning_status = 'ACTIVE' where id = '2e2edb16-ed37-4855-870e-dffb144a56dc';"

# Xử lý lỗi mà Amphora bị error và ko hearing lại
update amphora_health set busy = '0' where amphora_id = 'ec77ebce-02a6-4590-a2fc-28e5b58f3580';


migration_status

MariaDB [cinder]> select * from volumes where id ='1df1d829-1c9f-4989-a8b7-730bf458f02a' \G;
*************************** 1. row ***************************
                 created_at: 2022-08-11 02:13:06
                 updated_at: 2022-08-11 02:13:07
                 deleted_at: NULL
                    deleted: 0
                         id: 1df1d829-1c9f-4989-a8b7-730bf458f02a
                     ec2_id: NULL
                    user_id: 428f8ce2ee444a9f94e85be5131a10ba
                 project_id: 3678906b2e3f4d88a0e1ac05c688848f
                       host: controller02@controller02_hdd#controller02_hdd
                       size: 1
          availability_zone: nova
                     status: available
              attach_status: detached
               scheduled_at: 2022-08-11 02:13:06
                launched_at: 2022-08-11 02:13:07
              terminated_at: NULL
               display_name: vm-test
        display_description:
          provider_location: NULL
              provider_auth: NULL
                snapshot_id: NULL
             volume_type_id: e39f01d3-1ba7-4941-8bc9-647459709d31
               source_volid: NULL
                   bootable: 0
          provider_geometry: NULL
                   _name_id: NULL
          encryption_key_id: NULL
           migration_status: NULL
         replication_status: NULL
replication_extended_status: NULL
    replication_driver_data: NULL
        consistencygroup_id: NULL
                provider_id: NULL
                multiattach: 0
            previous_status: NULL
               cluster_name: NULL
                   group_id: NULL
               service_uuid: 77bcba1c-2557-4248-bf8e-b60189ee2819
             shared_targets: 0
