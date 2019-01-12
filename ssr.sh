#!/bin/bash

Install_BBR(){
	wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh
}

INSTALL(){
	if [ ! -f /usr/bin/ssr ];then
		wget -O /root/ssr_file.zip "https://github.com/qinghuas/ss-panel-and-ss-py-mu/archive/master.zip"
		unzip /root/ssr_file.zip -d /root;mv /root/ss-panel-and-ss-py-mu-master/* /root
		cp /root/ssr.sh /usr/bin/ssr;chmod 777 /usr/bin/ssr
		rm -rf ssr_file.zip /root/ss-panel-and-ss-py-mu-master /root/picture /root/README.md /root/ssr.sh
		clear;echo "INSTALL DONE,Hellow.";sleep 1
	fi
}

UPDATE_SHADOWSOCKS_COMMAND(){
	if [ -f /usr/bin/shadowsocks ];then
		wget -O /usr/bin/shadowsocks "https://raw.githubusercontent.com/qinghuas/ss-panel-and-ss-py-mu/master/node/ss"
		chmod 777 /usr/bin/shadowsocks
	fi
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
# GitHub  #  https://github.com/mmmwhy/ss-panel-and-ss-py-mu       #
# GitHub  #  https://github.com/qinghuas/ss-panel-and-ss-py-mu     #
# Edition #  V.3.1.6 2017-12-13                                    #
# From    #  @mmmwhy @qinghuas                                     #
####################################################################
# [ID]  [TYPE]  # [DESCRIBE]                                       #
####################################################################
# [1] [Install] # [LNMP] AND [SS PANEL V3]                         #
# [2] [Install] # [SS NODE] AND [BBR]                              #
# [3] [Change]  # [SS NODE INOF]                                   #
# [4] [Install] # [SS NODE]                                        #
# [5] [Install] # [BBR]                                            #
####################################################################
# [a]检查BBR状态 [b]安装/执行路由追踪 [c]Speedtest/UnixBench/bench #
# [d]更换镜像源 [e]安装/检查 Fail2ban [f]安装/执行 安全狗          #   
# [g]卸载阿里云云盾 [h]安装/卸载 锐速 [i]Nginx 管理脚本            #
# [j]安装纯净系统 [k]安装Aria2 [l]安装Server Status [m]安装Socks5  #
####################################################################
# [x]重新加载 [y]更新脚本 [z]删除脚本 [about]关于脚本              #
# ${SERVER_IP_INFO}
####################################################################"
read -p "PLEASE SELECT OPTIONS:" SSR_OPTIONS

clear;case "${SSR_OPTIONS}" in
	1)
	Install_the_front;;
	2)
	Install_ss_node
	Install_BBR;;
	3)
	Edit_ss_node_info;;
	4)
	Install_ss_node;;
	5)
	Install_BBR;;
	a)
	Check_BBR_installation_status;;
	b)
	Routing_track;;
	c)
	Run_Speedtest_And_Bench_sh;;
	d)
	Change_System_Source;;
	e)
	Install_fail2ban;;
	f)
	Install_Safe_Dog;;
	g)
	Uninstall_ali_cloud_shield;;
	h)
	Install_Serverspeeder;;
	i)
	Nginx_Administration_Script;;
	j)
	Installation_Of_Pure_System;;
	k)
	Install_Aria2;;
	l)
	Install_Server_Status;;
	m)
	Install_Socks5;;
	x)
	/usr/bin/ssr;;
	y)
	REINSTALL;;
	z)
	UNINSTALL;;
	about)
	cat /root/tools/about.txt;;
	node)
	GET_NODE_SH_FILE;;
	*)
	echo "选项不在范围内,2s后将重新加载,请注意选择...";sleep 2
	/usr/bin/ssr;;
esac

#END 2018-01-02 13:24
