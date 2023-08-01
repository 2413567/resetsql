#!/bin/bash

# 检查 MySQL 服务状态
mysql_status=$(sudo service mysql status)
if [[ $mysql_status == *"active (running)"* ]]; then
    # Step 1: 停止 MySQL 服务
    sudo service mysql stop
else
    echo "MySQL 服务已经停止，跳过停止服务的步骤。"
fi
# Step 2: 启动 MySQL 服务器并跳过权限验证
sudo mysqld_safe --skip-grant-tables &

# 等待 MySQL 启动
sleep 5

# Step 3: 重置 MySQL root 用户密码为 "admin"
sudo mysql -u root << EOF
USE mysql;

# 判断 MySQL 版本是否高于等于 5.7.6
mysql_version=\$(mysql -V | awk '{print \$5}')
major_version=\$(echo "\$mysql_version" | cut -d '.' -f1)
minor_version=\$(echo "\$mysql_version" | cut -d '.' -f2)
if (( \$major_version >= 5 && \$minor_version >= 7 )); then
    # MySQL 5.7.6 及更高版本，使用 ALTER USER 语句
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin';
else
    # MySQL 5.7.5 及更低版本，使用 UPDATE 语句
    UPDATE user SET authentication_string=PASSWORD('admin') WHERE User='root';
    FLUSH PRIVILEGES;
fi
EOF

# Step 4: 退出 MySQL
sudo mysqladmin -u root -p shutdown

# Step 5: 启动 MySQL 服务
sudo service mysql start

echo "MySQL root 用户密码已重置为 admin，请使用新密码登录。"
