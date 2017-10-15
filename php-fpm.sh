#!/bin/bash
#
# Author:miner_k
# version: 0.1.1

#wget http://am1.php.net/distributions/php-7.0.21.tar.gz

#PREFIX=/usr/local
#WEB_DATA=/www
#PHP_PACK=php-7.0.21.tar.gz

PHP_DIR=$(echo $PHP_PACK | awk -F'.tar' '{print $1}')


yum -y install libxml2 libxml2-devel openssl openssl-devel bzip2-devel

tar -xvf $PHP_PACK
cd $PHP_DIR
 ./configure --prefix=$PREFIX/php \
	--with-openssl \
	--with-mysqli=$PREFIX/mysql/bin/mysql_config \
	--enable-mbstring \
	--with-freetype-dir \
	--with-jpeg-dir \
	--with-png-dir \
	--with-zlib \
	--with-libxml-dir=/usr \
	--enable-xml  \
	--enable-sockets \
	--with-config-file-path=/etc \
	--with-config-file-scan-dir=/etc/php.d \
	--with-bz2 \
	--enable-fpm

make 
make install
cp php.ini-production /etc/php.ini
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm

cd $PREFIX/php/etc/
cp php-fpm.conf{.default,}
cp php-fpm.d/www.conf{.default,}


sed -i '/^listen/s/127.0.0.1/0.0.0.0/' $PREFIX/php/etc/php-fpm.d/www.conf
if [ ! -d $WEB_DATA ];then
	mkdir $WEB_DATA/
fi

cat <<-EOF > $WEB_DATA/index.php
<?php
phpinfo();
?>
EOF


service php-fpm start


