# Pyenv 使用

## 安装 Pythony 依赖

``` shell
# centos
yum install -y ncurses-libs zlib-devel mysql-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel gcc g++ patch make

#  ubuntu
sudo apt-get install libbz2-dev
sudo apt-get install libssl-dev
sudo apt-get install libreadline6 libreadline-dev
sudo apt-get install libsqlite3-dev
```

## 安装 pyenv

``` shell
git clone https://gitee.com/mirrors/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
# 配置初始环境
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
```

## 安装 pyenv virtualenv

``` shell
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
#　配置自动激活
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

# 加载配置文件
source ~/.zshrc
```

## 使用

``` shell
# 安装不同版本的Python
pyenv install 3.5.5
# 查看当前python版本
pyenv version
# 查看所有已安装Python版本
# 卸载不同环境Python
pyenv uninstall 3.3.5
# 切换不同版本
pyenv global 3.3.5
# 创建虚拟环境
pyenv virtualenv 3.3.5 django
# 退出环境
pyenv deactivate
# 进入虚拟环境
pyenv activate django
# 删除虚拟环境, 直接删除虚拟环境文件夹
rm -rf ~/.pyenv/versions/3.5.5
```

## 注意

- 当 Ubuntu 系统安装完 sqlite3 报错
    `ImportError: No module named '_sqlite3'`

- 解决方案
    `sudo apt install libsqlite3-dev`
