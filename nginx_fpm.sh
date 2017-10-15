#!/bin/bash
#
# version:0.1.1
# author:miner-k
#

#CONF_PATH_DIR=/etc/nginx
#WEB_DATA=/www
#FPM_IP=127.0.0.1


sed -i "/WEB_DATA/s#WEB_DATA#$WEB_DATA#" nginx.conf
sed -i "/FPM_IP/s#FPM_IP#$FPM_IP#" nginx.conf

mv $CONF_PATH_DIR/nginx.conf{,.bak}
mv $CONF_PATH_DIR/fastcgi_params{,.bak}

cp nginx.conf $CONF_PATH_DIR
cp fastcgi_params $CONF_PATH_DIR

service nginx restart
