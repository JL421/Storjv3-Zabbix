A Zabbix template for monitoring a Storjv3 node. Uses zabbix_sender to send stats to the Zabbix server defined in your zabbix agent config.

Prerequisites:
Linux Server
Cron
Zabbix Agent
Zabbix user added to Docker group

Steps:
1) Add Template to Zabbix
2) Add script to Storj node.
  a) You may want to edit the temp file location to suit your distro. (Defaults to /tmp/zabbix-storagenode-stats)
  b) Update location for Zabbix Agent config if necessary (Defaults to /etc/zabbix/zabbix_agentd.conf)
3) Chmod +x for the script.
4) Add to cron task for zabbix user to run the script every minute.
  Note: You might be able to run less frequently, but you may have to update the formulas for the storjv3.*.hourly values. I'm not sure if the data showing up less frequently would distort those values or not.
5) Verify the data is showing up for your node in Zabbix.
