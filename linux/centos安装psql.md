# centos 安装 psql

## 安装

``` shell
 rpm -Uvh https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm

 yum install -y postgresql10-server postgresql10

```

## 初始化

``` shell
/usr/pgsql-10/bin/postgresql-10-setup initdb

# PostgreSQL文件默认放在路径: /var/lib/pgsql/10/data/
```

## 启动

``` shell
systemctl start postgresql-10
systemctl enable postgresql-10
systemctl status postgresql-10
```

## 连接

``` shell
# 登陆
su -l postgres
# 链接
psql
# 重置密码
\password
```

## 添加用户

``` sql
create user root with password '123456';

-- 创建数据库并且指定所属用户
create database test owner root;
```
