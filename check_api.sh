#!/bin/bash

URL="http://127.0.0.1/api/"

if curl -fsS --max-time 3 "$URL" > /dev/null; then
    echo "$(date '+%F %T') API正常"
else
    echo "$(date '+%F %T') API异常"
fi
