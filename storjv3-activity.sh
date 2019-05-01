#!/bin/bash

Uploads=0
Downloads=0
Deletes=0
CanceledUps=0
CanceledDowns=0

if [ -f /tmp/zabbix-storagenode-stats ]
then
	LastRun=$(stat -c %y /tmp/zabbix-storagenode-stats | awk '{print $1"T"$2}')
else
	LastRun="1m"
fi

OLDIFS=$IFS

IFS=$'\n' StorjLogs=$(docker logs --since $LastRun storagenode 2>&1)

touch /tmp/zabbix-storagenode-stats

for i in $StorjLogs
do
	Operation1=$(awk '{print $4}' <<< $i)
	Operation2=$(awk '{print $5}' <<< $i)

	if [ -z "$Operation1" ]
	then
		continue
	elif [ $Operation1 == "uploaded" ]
	then
		let "Uploads++"
	elif [ $Operation1 == "downloaded" ]
	then
		let "Downloads++"
	elif [ $Operation1 == "deleted" ]
	then
		let "Deletes++"
	elif [[ $Operation1 == "upload" && $Operation2 == "failed" ]]
	then
		let "CanceledUps++"
	elif [[ $Operation1 == "download" && $Operation2 == "failed" ]]
	then
		let "CanceledDowns++"
	else
		echo $Operation1
	fi
done

echo "- storjv3.canceleddowns $CanceledDowns
- storjv3.canceledups $CanceledUps
- storjv3.deletes $Deletes
- storjv3.uploads $Uploads
- storjv3.downloads $Downloads" | zabbix_sender -c /etc/zabbix/zabbix_agentd.conf -i -
