#!/bin/sh

sudo kill -9 `cat /usr/local/nginx/logs/nginx.pid`

kill_nginx_workers.sh

sudo nginx
