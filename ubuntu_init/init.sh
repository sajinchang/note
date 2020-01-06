#!/usr/bin/env bash

# ubuntu 系统初始化

read -s -p "enter the sudo password:" PASSWORD

# sudo app-key -adv --recv --keyserver kerserver.ubuntu.com $KEY

system_update() {
    echo "系统更新"
    apt update -y
    apt upgrade -y
    echo -e "系统更新完成"
}

install_software() {
    BASIC='man gcc make sudo lsof ssh openssl tree vim language-pack-zh-hans'
    EXT='dnsutils iputils-ping net-tools psmisc sysstat'
    NETWORK='curl telnet traceroute wget'
    LIBS='libbz2-dev libpcre3 libpcre3-dev libreadline-dev libsqlite3-dev libssl-dev zlib1g-dev'
    SOFTWARE='git mysql-server zip p7zip apache2-utils sendmail'
    OTHER='git lrzsz mysql-server redis mongodb zsh deepin-terminal deepin-screenshot'
    WORK='google-chrome-stable sublime-text teamviewer obs-server obs-studio vlc'
    echo "install system software ..."
    apt install -y $BASIC $EXT $NETWORK $LIBS $SOFTWARE $OTHER $WORK
    echo "system software installed "
}

install_onmyzsh() {
    echo "安装 on-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    chsh -s /usr/bin/zsh
    ehco "oh-my-zsh 安装完成"
}

install_pyenv() {
    ehco "安装pyenv"
    git clone https://gitee.com/mirrors/pyenv.git ~/.pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    echo "pyenv 安装完成"
}

copy_profile() {
    cp ./doc/vimrc $HOME/.vimrc
    cp -r ./doc/pip $HOME/.pip
    cp ./doc/zshrc $HOME/.zshrc
}

install_python() {
    if [ ! pyenv versions | grep 3.6.7 ] >/dev/null; then
        pyenv install 3.6.7
        echo -e "python 3.6.7 安装完成"
    else
        echo "python 3.6.7 安装完成"
    fi
}

install_all() {
    system_update
    install_software
    install_onmyzsh
    install_pyenv
    copy_profile
    install_python
}

cat <<EOF
请输入要执行的操作的编号: [1-9]
===============================
【 1 】 系统更新
【 2 】 安装软件
【 3 】 安装 oh-my-zsh
【 4 】 安装 Pyenv
【 5 】 复制配置文件
【 6 】 安装 Python
【 0 】 全部执行
【 Q 】 退出
===============================
EOF

if [ -n $1 ]; then
    input=$1
    echo "执行操作 $1"
else
    read -p "请选择:" input
fi

case $input in
1) system_update ;;
2) install_software ;;
3) install_onmyzsh ;;
4) install_pyenv ;;
5) copy_profile ;;
6) install_python ;;
0) install_all ;;
*)
    exit
    ;;
esac
