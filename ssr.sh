#!/bin/bash

Install_BBR(){
	wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh
}

Installation_Of_Pure_System(){
	bash /root/tools/reinstall.sh
}

GET_SERVER_IP(){
	if [ ! -f /root/.ip.txt ];then
		curl -s 'https://myip.ipip.net' > /root/.ip.txt
		Number_of_file_characters=`cat .ip.txt | wc -L`
		if [ ${Number_of_file_characters} -gt '100' ];then
			curl -s 'http://ip.cn' > /root/.ip.txt
		fi
	fi
	SERVER_IP_INFO=`sed -n '1p' /root/.ip.txt`
}

UNINSTALL(){
	rm -rf /usr/bin/ssr /root/tools /root/node /root/.ip.txt
	clear;echo "UNINSTALL DONE,Bye."
}

REINSTALL(){
	UNINSTALL
	INSTALL
	UPDATE_SHADOWSOCKS_COMMAND
	clear;echo "REINSTALL DONE,Meet Again."
}

GET_NODE_SH_FILE(){
	if [ ! -f /root/node.sh ];then
		wget "https://dl.52ll.org/node.sh";chmod 777 node.sh
	else
		echo "node.sh 已存在."
	fi
}

INSTALL
GET_SERVER_IP

echo "####################################################################
# 阿 明 个 人 定 制 版                                             #
####################################################################
# [1] [安装BBR锐速合集版-94ish.me]                                 #
# [2] [待定.]                                                      #
####################################################################
# [z]重新加载 [x]更新脚本 [c]删除脚本 [v]关于脚本                  #
# ${SERVER_IP_INFO}
####################################################################"
read -p "PLEASE SELECT OPTIONS:" SSR_OPTIONS

clear;case "${SSR_OPTIONS}" in
	1)
	Install_BBR;;
	z)
	/usr/bin/ssr;;
	x)
	REINSTALL;;
	c)
	UNINSTALL;;
	v)
	cat /root/tools/about.txt;;
	node)
	GET_NODE_SH_FILE;;
	*)
	echo "选项不在范围内,2s后将重新加载,请注意选择...";sleep 2
	/usr/bin/ssr;;
esac

#END 2018-01-02 13:24
