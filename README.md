# Health Check

一个用于学习 Linux 运维、Bash 脚本、Nginx、systemd、Git 和 GitHub 的健康检查实战项目。

## 项目功能

- `check_api.sh`：检查 API 是否正常，根据 HTTP 状态码和 curl 退出码判断检查结果。
- `monitor_api.sh`：调用健康检查脚本，记录连续失败次数，并在连续失败 3 次时写入告警日志。
- `hello.sh`：输出服务信息并根据请求结果判断服务状态。
- `test1.sh`：练习 Bash 变量和条件判断。
- `fail_count`：保存当前连续失败次数，API 检查正常时清零。
- `monitor.log`：记录 API 连续失败告警。
- `cron.log`：记录 cron 定时执行时的标准输出和错误输出。
- `.gitignore`：忽略日志文件和 Python 缓存目录。

## 运行环境

- Linux / CentOS
- Bash
- curl
- Nginx
- Python API 服务
- systemd
- cron
- Git / GitHub

## 项目架构

```text
用户请求
   |
   v
Nginx
   |
   | /api/
   v
Python API（127.0.0.1:8080）

cron 定时任务
   |
   v
monitor_api.sh
   |
   v
check_api.sh
   |
   +-- 检查 API 状态
   +-- 更新 fail_count
   +-- 连续失败 3 次时记录告警
```

## 检查地址

默认地址：

`http://127.0.0.1/api/`

运行前请启动 Python API 服务，并确认 Nginx 的 `/api/` 反向代理配置正确。

## 运行方式

进入项目目录：

```bash
cd /root/health-check
```

运行 API 健康检查：

```bash
bash check_api.sh
```

运行连续失败监控：

```bash
bash monitor_api.sh
```

运行服务信息检查：

```bash
bash hello.sh
```

运行条件判断练习：

```bash
bash test1.sh
```

## 连续失败告警逻辑

`monitor_api.sh` 调用 `check_api.sh`，根据脚本退出状态判断 API 是否正常。

- 检查正常：将 `fail_count` 重置为 `0`。
- 检查失败：读取当前计数并加 `1`。
- 连续失败达到 `3` 次：向 `monitor.log` 追加告警记录。

告警记录示例：

```text
2026-10-22 05:12:39 ALERT: API连续失败3次
```

## 定时任务

当前 cron 配置为每分钟执行一次监控脚本：

```cron
* * * * * /bin/bash /root/health-check/monitor_api.sh >> /root/health-check/cron.log 2>&1
```

查看当前定时任务：

```bash
crontab -l
```

查看定时任务日志：

```bash
tail -n 10 /root/health-check/cron.log
```

查看告警日志：

```bash
tail -n 10 /root/health-check/monitor.log
```

## 实际测试记录

- Python API 正常运行时，健康检查返回 HTTP 200。
- 停止 Python API 后，Nginx 代理请求返回 HTTP 502。
- 连续运行监控脚本 3 次后，`fail_count` 从 `1` 增加到 `3`。
- 第 3 次失败时，`monitor.log` 中出现连续失败告警。
- 恢复 Python API 后，失败计数清零。

## 学习目标

- Linux 服务管理与故障排查
- Bash 脚本编写与退出码判断
- HTTP 状态检查
- 连续失败计数与告警日志
- cron 定时任务
- Git 版本控制与 GitHub 远程仓库管理

## 后续计划

- 完善异常处理和日志管理。
- 使用 Docker 部署服务。
- 尝试通过 CI/CD 自动执行检查。
- 继续完善项目文档与自动化运维能力。
