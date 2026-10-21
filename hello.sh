#!/bin/bash
name="Python API"
status=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 3 http://127.0.0.1/api/)
curl_exit=$?
api="http://127.0.0.1/api/"
date=$(date '+%F %T')
echo "服务名称: $name"
echo "服务地址: $api"
echo "检查时间: $date"
if [ "$curl_exit" -ne 0 ]; then
	echo "请求失败"
else
	if [ "$status" -eq 200 ]; then
        	echo "Python API 服务正常"
	else
        	echo "Python API 服务异常"
	fi
fi

# Git practice
# Practice Git diff
