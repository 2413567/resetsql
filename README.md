# MySQL Root Password Reset Script

这是一个 Bash 脚本，用于重置 MySQL root 用户的密码。以下是脚本的详细步骤和使用方法。

## 脚本步骤

1. 停止 MySQL 服务：使用 `sudo service mysql stop` 命令停止 MySQL 服务。

2. 启动 MySQL 服务器并跳过权限验证：使用 `sudo mysqld_safe --skip-grant-tables &` 命令以安全模式启动 MySQL 服务器，并跳过权限验证。

3. 重置 MySQL root 用户密码：使用 `sudo mysql -u root` 命令以 root 用户身份登录 MySQL，然后根据 MySQL 版本的不同，使用不同的 SQL 语句重置 root 用户的密码。如果 MySQL 版本高于等于 5.7.6，使用 `ALTER USER` 语句；如果 MySQL 版本低于 5.7.6，使用 `UPDATE` 语句。

4. 退出 MySQL：使用 `sudo mysqladmin -u root -p shutdown` 命令关闭 MySQL 服务器。

5. 启动 MySQL 服务：使用 `sudo service mysql start` 命令重新启动 MySQL 服务。

最后，脚本会输出一条消息，告知用户 MySQL root 用户的密码已经被重置为 "admin"，并提示用户使用新密码登录。

## 使用方法

1. 将脚本保存为 `.sh` 文件，例如 `reset_mysql_root_password.sh`。

2. 在终端中，使用 `chmod` 命令给脚本添加执行权限，例如 `chmod +x reset_mysql_root_password.sh`。

3. 在终端中，使用 `./reset_mysql_root_password.sh` 命令运行脚本。

## 注意事项

- 这个脚本需要在具有 sudo 权限的 Linux 系统上运行，并且需要确保 MySQL 服务已经安装并正确配置。

- 在运行这个脚本之前，建议先备份所有重要的数据库和数据，以防止任何可能的数据丢失。

- 如果你想使用不同的新密码，你可以在脚本中修改 `admin` 为你想要的新密码。

- 如果你在使用这个脚本时遇到任何问题，你可以查看 MySQL 的官方文档，或者在网上搜索相关的解决方案。
