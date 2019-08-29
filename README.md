A Zabbix template for monitoring a Storjv3 node. Uses zabbix_sender to send stats to the Zabbix server defined in your zabbix agent config.

Tested on Ubuntu Server 18.04, but should work on any system with bash 4+

Prerequisites:
* Linux Server
* Cron
* Zabbix Agent
* Zabbix user added to Docker group
* Zabbix 4+
* Storj Node 19.0.0+ for bandwidth, storage, and satellite monitoring

Steps:
1) Add Template to Zabbix
2) Add script to Storj node.
    1) You may want to edit the temp file location to suit your distro. (Defaults to /tmp/zabbix-storagenode-stats)
    2) Update location for Zabbix Agent config if necessary (Defaults to /etc/zabbix/zabbix_agentd.conf)
3) Chmod +x for the script.
4) Add to cron task for zabbix user to run the script every minute.
    1) Note: You might be able to run less frequently, but you may have to update the formulas for the storjv3.*.hourly values. I'm not sure if the data showing up less frequently would distort those values or not.
5) Add the following line to your config.yaml: console.address: :14002
    1) This allows the storage node API to listen on any address, including the host's address. 
    2) Note: This may be dangerous, the full extent of the API functionality is unknown at this time. It is suggested to not enable this option on nodes directly on the Internet, or to setup ACLs limiting access to this port.
6) Verify the data is showing up for your node in Zabbix.
