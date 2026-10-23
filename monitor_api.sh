#!/bin/bash

if [ ! -f "/root/health-check/fail_count" ];then
	echo 0 > /root/health-check/fail_count
fi

if bash /root/health-check/check_api.sh;then
	echo 0 > /root/health-check/fail_count
else 	
	read count < /root/health-check/fail_count
	count=$((count+1))
	echo $count > /root/health-check/fail_count 
	if [ "$count" -eq 3 ];then
		echo "$(date '+%F %T') ALERT: API连续失败3次" >> /root/health-check/monitor.log
	fi
fi
