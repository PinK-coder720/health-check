PROJECT_DIR="/root/health-check"
COUNT_FILE="$PROJECT_DIR/fail_count"
LOG_FILE="$PROJECT_DIR/monitor.log"

# 初始化失败计数文件
if [ ! -f "$COUNT_FILE" ]; then
    echo 0 > "$COUNT_FILE"
fi

if bash "$PROJECT_DIR/check_api.sh"; then
    echo 0 > "$COUNT_FILE"
else
    read -r count < "$COUNT_FILE"
    count=$((count + 1))
    echo "$count" > "$COUNT_FILE"

    # 连续失败达到3次时，尝试自动恢复
    if [ "$count" -eq 3 ]; then
        echo "$(date '+%F %T') ALERT: API连续失败3次，尝试重启python-api" >> "$LOG_FILE"

        if systemctl restart python-api; then
            sleep 3

            if bash "$PROJECT_DIR/check_api.sh"; then
                echo "$(date '+%F %T') RECOVERY: API自动恢复成功" >> "$LOG_FILE"
                echo 0 > "$COUNT_FILE"
            else
                echo "$(date '+%F %T') ERROR: 重启后API仍然异常" >> "$LOG_FILE"
            fi
        else
            echo "$(date '+%F %T') ERROR: python-api重启命令执行失败" >> "$LOG_FILE"
        fi
    fi
fi

