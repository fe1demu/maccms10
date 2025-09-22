#!/bin/bash

# 数据库配置文件路径
DB_CONFIG_FILE="/var/www/html/application/database.php"

# 如果数据库配置文件存在，则进行环境变量替换
if [ -f "$DB_CONFIG_FILE" ]; then
    echo "正在配置数据库连接..."
    
    # 替换数据库配置（使用环境变量）
    if [ ! -z "$DB_HOST" ]; then
        sed -i "s/'hostname'[[:space:]]*=>[[:space:]]*'[^']*'/'hostname'    => '$DB_HOST'/g" $DB_CONFIG_FILE
        echo "数据库主机设置为: $DB_HOST"
    fi
    
    if [ ! -z "$DB_NAME" ]; then
        sed -i "s/'database'[[:space:]]*=>[[:space:]]*'[^']*'/'database'    => '$DB_NAME'/g" $DB_CONFIG_FILE
        echo "数据库名称设置为: $DB_NAME"
    fi
    
    if [ ! -z "$DB_USER" ]; then
        sed -i "s/'username'[[:space:]]*=>[[:space:]]*'[^']*'/'username'    => '$DB_USER'/g" $DB_CONFIG_FILE
        echo "数据库用户设置为: $DB_USER"
    fi
    
    if [ ! -z "$DB_PASS" ]; then
        sed -i "s/'password'[[:space:]]*=>[[:space:]]*'[^']*'/'password'    => '$DB_PASS'/g" $DB_CONFIG_FILE
        echo "数据库密码已设置"
    fi
    
    if [ ! -z "$DB_PORT" ]; then
        sed -i "s/'hostport'[[:space:]]*=>[[:space:]]*'[^']*'/'hostport'    => '$DB_PORT'/g" $DB_CONFIG_FILE
        echo "数据库端口设置为: $DB_PORT"
    fi
else
    echo "警告: 数据库配置文件不存在: $DB_CONFIG_FILE"
fi

# 强制设置 runtime 目录权限
mkdir -p /var/www/html/runtime
chmod -R 777 /var/www/html/runtime
chown -R www-data:www-data /var/www/html/runtime
echo "Runtime 目录权限已设置为 777"

echo "正在启动Apache..."
# 启动Apache
exec apache2-foreground
