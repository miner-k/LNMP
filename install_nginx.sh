#!/bin/bash

wget http://nginx.org/download/nginx-1.12.1.tar.gz

yum -y install pcre-devel
yum -y groupinstall  "Development tools"




PREFIX=/usr/local
SBIN_PATH=/usr/local/nginx/nginx
CONF_PATH=/etc/nginx/nginx.conf
PID_PATH=/var/run/nginx/nginx.pid
ERROR_LOG_PATH=/var/log/nginx/error.log
HTTP_LOG_PATH=/var/log/nginx/access.log
LOCK_PATH=/var/lock/nginx.lock


unpack(){
        tar -xf $1
        dir=$(echo $1 | awk -F'.tar' '{print $1}')
        cd $dir
}

install(){
        make
        make install
        cd ..
}

unpack

./configure \
  --prefix=$PREFIX \
  --sbin-path=$SBIN_PATH \
  --conf-path=$CONF_PATH \
  --error-log-path=$ERROR_LOG_PATH \
  --http-log-path=$HTTP_LOG_PATH \
  --pid-path=$PID_PATH  \
  --lock-path=$LOCK_PATH \
  --user=nginx \
  --group=nginx \
  --with-http_ssl_module \
  --with-http_flv_module \
  --with-http_stub_status_module \
  --with-http_gzip_static_module \
  --http-client-body-temp-path=/var/tmp/nginx/client/ \
  --http-proxy-temp-path=/var/tmp/nginx/proxy/ \
  --http-fastcgi-temp-path=/var/tmp/nginx/fcgi/ \
  --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
  --http-scgi-temp-path=/var/tmp/nginx/scgi \
  --with-pcre

install


cp nginx /etc/init.d/
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig nginx on
service nginx start
