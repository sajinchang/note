# CeotOS7 安装 MySQL

``` shell
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm

rpm -ivh mysql57-community-release-el7-9.noarch.rpm

yum install mysql-server -y

# 启动MySQL
systemctl start mysqld

# 查看临时密码
grep 'temporary password' /var/log/mysqld.log

# 设置安全选项
mysql_secure_installation

# 登录
mysql -u root -p

# 查看密码策略
show variables like '%password%'

# 修改密码策略
set global validate_password_length=4

# 选择0（LOW），1（MEDIUM），2（STRONG）其中一种，选择2需要提供密码字典文件
set global validate_password_policy=0
set global validate_password_policy=LOW

# 修改密码
set password=password('123456')

# 添加远程登录用户
grant all privileges on *.* to 'root'@'%' identified by '123456' with grant option

# 刷新权限
flush privileges
```
