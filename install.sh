#!/bin/bash
#
# Author:miner_k
# Version:0.0.1
# 


menu(){
	clear
	cat <<-EOF
	##############################################################

	1.get packages of LNMP(nginx 1.12.1 + MySQL5.7.17 + PHP 7.0.21)
	2.install nginx
	3.install MySQL
	4.install PHP-fpm
	5.modify the nginx configuration file
	q.exit
	##############################################################
	EOF
}

source config
while :
do
	menu
	
	read -p "输入对应的编号：" num
	case $num in
		1) bash get_src.sh
		;;

		2) bash install_nginx.sh
		;;
		3) bash mysqld_bin.sh
		;;
		4) bash php-fpm.sh
		;;
		5) bash nginx_fpm.sh
		;;
		q) exit 0
		;;
		*)
		echo "输入错误" ;;
	esac 
done


