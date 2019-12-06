# CentOS7 换源

``` shell
cd /etc/yum.repos.d/

mv CentOS7-Base.repo CentOS7-Base.repo.bak

curl -O http://mirrors.163.com/.help/CentOS7-Base-163.repo

mv CentOS7-Base-163.repo CentOS-Base.repo

yum clean all

yum makecache
```
