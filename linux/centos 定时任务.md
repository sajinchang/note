# CentOS 定时任务

## at 一次性任务

```shell
☁  ~  at 16:05
at> systemctl stop nginx
at> <EOT>   # 编写完成按 Ctrl+D 保存生效
job 2 at Fri Dec  6 16:05:00 2019

# 查看
☁  ~  at -l
3   Fri Dec  6 16:30:00 2019 a root

# 删除
☁  ~  atrm 4   # 任务编号
☁  ~
```

## crontab 周期性执行

### 更改 crontab 的默认编辑器（该命令适用于 ubuntu, centos 默认为 vim)

```shell
╭─sam@sam-work ~
╰─$ select-editor
Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic
  3. /usr/bin/vim.tiny
  4. /usr/bin/code
  5. /bin/ed

Choose 1-5 [1]: 2
```

### 添加定时任务 (crontab -e)

==分 时 日 月 星期 command==

crontab 任务的参数 字段说明
|字段|说明|
|:---:|:---:|
|分|取值为0-59的整数|
|时|取值为0-23的整数|
|日|取值为1-31的整数|
|月|取值为1-12的整数|
|星期|取值为0-7的整数(0和7均为星期天)|
|命令|要执行的命令或者程序脚本(命令须使用绝对路径)|

为别的用户创建定时任务
`crontab -e -u username`
为用户自己创建定时任务无需使用 -u 参数

当某些时间字段没有设置时,需要使用 `*` 占位
多个时间段使用 `,` 分割
一段连续的时间周期 `-` 分割
`/` 任务执行的间隔时间
==计划任务中分字段必须有值, 绝对不可以为空或者`*`, 日和星期不可以同时使用,否则会出现冲突==

```shell
# Edit this file to introduce tasks to be run by cron.
#
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command  
# 分  时  日  月  星期

# 使用 * 占位
# 每天晚上00:00重启nginx服务
0 0 * * * systemctl restart nginx


# , 分割
# 周一,周三,周五晚上00:00重启nginx服务
0 0 * * 1,3,5 systemctl restart nginx

# - 分割
# 每月12-15号晚上00:00重启nginx服务
0 0 12-15 * systemctl restart nginx

# / 分割
# 每三个小时重启一次nginx
0 */3 * * systemctl restart nginx
```

### 查看定时任务(crontab -l)

```shell
☁  ~  crontab -l
53 16 * * 1,3,5 /usr/bin/touch /root/a.py
```
