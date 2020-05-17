#!/usr/bin/env bash
ENV=/root/.pyenv/versions/django/bin/activate
source $ENV
PRO=/apps/code/d_blog
INI=$PRO/uwsgi.ini
PID=/app/log/blog/uwsgi.pid
STATUSFILE=/app/log/blog/wsgi.status
cd $PRO

usage() {
    cat <<EOF
    usage:
        start:  start uwsgi server
        stop: stop uwsgi server
        relaod/restart: restart uwsgi server
        status: echo uwsgi server status

    e.g.
        ./uwsgi.sh start 
        ./uwsgi.sh stop 
        ./uwsgi.sh reload 
EOF

}

exc_command() {
    if [ "$1" == start ]; then
        uwsgi --ini $INI
    elif [ "$1" == stop ]; then
        uwsgi --stop $PID
    elif [ "$1" == reload ] || [ "$command" == restart ]; then
        uwsgi --reload $PID
    elif [ "$1" == status ]; then
        uwsgi --connect-and-read $STATUSFILE
    else
        echo "bad command"
    fi
}

command=$1

case $command in
start | stop | reload | restart | status)
    exc_command $command
    ;;
*)
    usage
    ;;
esac

deactivate
