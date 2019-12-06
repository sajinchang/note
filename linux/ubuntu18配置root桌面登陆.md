# ubuntu18 配置桌面root登陆

## 打开配置文件

```shell
sudo vim /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf

# 最后一行添加
greeter-show-manual-login=true
```

## 设置root密码

```shell
sudo passwd root
```

## 打开/root/.profile文件

```shell
vim /root/.profile

# 最后一行修改为
tty -s && mesg n || true
```

## root使用音频设备

```shell
vim /etc/profile

# 最后一行添加
pulseaudio --start --log-target=syslog
```

##　注释pam.d下的文件

```shell
sudo vim /etc/pam.d/gdm-autologin
# 注释这一行
"auth requied pam_succeed_if.so user != root quiet success"

sudo vim /etc/pam.d/gdm-password
# 注释这一行
"auth requied pam_succeed_if.so user != root quiet success"
```

==**然后可以进行root登陆了**==
