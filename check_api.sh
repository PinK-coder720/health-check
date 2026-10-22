#!/bin/bash

URL="http://127.0.0.1/api/"
TIMEOUT=3

status=$(curl -sS -o /dev/null -w '%{http_code}' --max-time "$TIMEOUT" "$URL" 2>/dev/null)
curl_exit=$?

date_now=$(date '+%F %T')

if [ "$curl_exit" -eq 28 ]; then
    echo "$date_now API请求超时"
    exit 3
elif [ "$curl_exit" -eq 7 ]; then
    echo "$date_now API连接失败"
    exit 2
elif [ "$curl_exit" -ne 0 ]; then
    echo "$date_now API请求失败，curl退出码: $curl_exit"
    exit 4
elif [ "$status" = "200" ]; then
    echo "$date_now API正常，HTTP状态码: $status"
    exit 0
else
    echo "$date_now API异常，HTTP状态码: $status"
    exit 1
fi
