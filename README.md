# Health Check

一个用于学习 Linux 运维、Bash 脚本、Git 和 GitHub 的健康检查练习项目。

## 项目功能

- `check_api.sh`：检查 API 是否正常，并输出检查时间。
- `hello.sh`：输出服务信息并根据请求结果判断服务状态。
- `test1.sh`：练习 Bash 变量和条件判断。
- `.gitignore`：忽略日志文件和 Python 缓存目录。

## 运行环境

- Linux / CentOS
- Bash
- curl
- Nginx
- Python API 服务

## 检查地址

默认地址：`http://127.0.0.1/api/`

运行前请启动 Python API 服务，并确认 Nginx 的 `/api/` 反向代理配置正确。

## 运行方式

进入项目目录：

    cd /root/health-check

运行 API 健康检查：

    bash check_api.sh

运行服务信息检查：

    bash hello.sh

运行条件判断练习：

    bash test1.sh

## 学习目标

- Linux 服务管理与故障排查
- Bash 脚本编写
- HTTP 状态检查
- Git 版本控制与 GitHub 远程仓库管理

## 后续计划

- 改进健康检查逻辑
- 增加日志记录
- 使用定时任务执行健康检查
- 使用 Docker 部署服务
- 尝试通过 CI/CD 自动执行检查
