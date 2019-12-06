# Firewall 防火墙

## systemctl 使用

``` shell
# 启动服务
systemctl start firewalld.service
# 关闭服务
systemctl stop firewalld.service
# 重启服务
systemctl restart firewalld.service
# 显示服务的状态
systemctl status firewalld.service
# 开机时启用一个服务
systemctl enable firewalld.service
# 开机时禁用一个服务
systemctl disable firewalld.service
# 查看服务是否开机启动
systemctl is-enabled firewalld.service
# 查看已启动的服务列表
systemctl list-unit-files | grep enabled
# 查看启动失败的服务列表
systemctl --failed
```

## firewall 配置

``` shell
# 查看版本
firewall-cmd --version
# 查看帮助
firewall-cmd --help
# 显示状态
firewall-cmd --state
# 查看所有打开的端口
firewall-cmd --zone=public --list-ports
# 更新防火墙规则
firewall-cmd --reload
# 查看区域信息
firewall-cmd --get-active-zones
# 查看指定接口所属区域
firewall-cmd --get-zone-of-interface=ens33
# 拒绝所有包
firewall-cmd --panic-on
# 取消拒绝状态
firewall-cmd --panic-off
# 查看是否拒绝
firewall-cmd --query-panic
```

## 具体端口操作

``` shell
# 开启一个端口
firewall-cmd --zone=public --add-port=22/tc --permanent (--permanent: 永久生效,若没有此参数重启失效)
# 重新载入
firewall-cmd --reload
# c查看
firewall-cmd --zone=public --query-port=22/tcp
# 删除
firewall-cmd --zone=public --remove-port=22/tcp --permanent
# 查看还有那些服务可以打开
firewall-cmd --get-services
# 查看所有打开的端口
firewall-cmd --zone=public --list-ports
```
