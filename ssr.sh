#!/bin/bash

Install_BBR(){
	wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh
}

Install_ss1_node(){
	yum -y install wget && wget -N --no-check-certificate https://raw.githubusercontent.com/yyyyy1412/zmou/master/ssnew.sh && chmod +x ssnew.sh && bash ssnew.sh
}

Install_ss2_node(){
	yum -y install wget && wget -N --no-check-certificate https://raw.githubusercontent.com/yyyyy1412/zmou/master/ss.sh && chmod +x ss.sh && bash ss.sh
}

Install_fail2ban(){
	if [ ! -f /etc/fail2ban/jail.local ];then
		echo "检测到未安装fail2ban,将先进行安装...";sleep 2.5
		bash /root/tools/fail2ban.sh
	else
		fail2ban-client ping;echo -e "\033[31m[↑]正常返回值:Server replied: pong\033[0m"
		#iptables --list -n;echo -e "\033[31m#当前iptables禁止规则\033[0m"
		fail2ban-client status;echo -e "\033[31m[↑]当前封禁列表\033[0m"
		fail2ban-client status ssh-iptables;echo -e "\033[31m[↑]当前被封禁的IP列表\033[0m"
		sed -n '12,14p' /etc/fail2ban/jail.local;echo -e "\033[31m[↑]当前fail2ban配置\033[0m"
	fi
	
	echo;read -p "输入[n]则退出;输入一个ipv4地址则将为其解除fail2ban封锁:" N_OR_IP
	case "${N_OR_IP}" in
	n)
		echo "退出.";;
	*)
		fail2ban-client set ssh-iptables unbanip ${N_OR_IP};;
	esac
}

Uninstall_ali_cloud_shield(){
	echo "请根据阿里云系统镜像安装环境,选项相应选项!"
	echo "选项: [1]系统自控制台重装 [2]系统自快照/镜像恢复 [3]更换内核并安装LotServer"
	read -p "请选择选项:" Uninstall_ali_cloud_shield_options
	
	case "${Uninstall_ali_cloud_shield_options}" in
		1)
		bash /root/tools/alibabacloud/New_installation.sh;;
		2)
		bash /root/tools/alibabacloud/Snapshot_image.sh;;
		3)
		bash /root/tools/alibabacloud/install.sh;;
		*)
		echo "选项不在范围!";exit 0;;
	esac
}

Change_System_Source(){
	bash /root/tools/change_source.sh
}

Routing_track(){
	bash /root/tools/traceroute.sh
}

Run_Speedtest_And_Bench_sh(){
	read -p "执行SpeedTest?[y/n]:" SpeedTest
	case "${SpeedTest}" in
	y)
		chmod 777 /root/tools/speedtest.py
		cd /root/tools;./speedtest.py;cd /root;;
	*)
		echo "跳过.";echo;;
	esac

	read -p "执行UnixBench?[y/n]:" UnixBench
	case "${UnixBench}" in
	y)
		chmod 777 /root/tools/unixbench.sh
		cd /root/tools;./unixbench.sh;cd /root;;
	*)
		echo "跳过.";echo;;
	esac

	read -p "执行Bench SH?[y/n]:" Bench_SH
	case "${Bench_SH}" in
	y)
		wget -qO- bench.sh | bash;;
	*)
		echo "跳过.";echo;;
	esac
}

Edit_ss_node_info(){
	echo "旧设置如下:"
	sed -n '2p' /root/shadowsocks/userapiconfig.py
	sed -n '17,18p' /root/shadowsocks/userapiconfig.py
	
	echo;read -p "(1/3)请设置新的前端地址:" Front_end_address
	read -p "(2/3)请设置新的节点ID:" Node_ID
	read -p "(3/3)请设置新的Mukey:" Mukey
	
	if [[ ${Mukey} = '' ]];then
		Mukey='mupass';echo "emm,我们已将Mukey设置为:mupass"
	fi
	
	sed -i "17c WEBAPI_URL = \'${Front_end_address}\'" /root/shadowsocks/userapiconfig.py
	sed -i "2c NODE_ID = ${Node_ID}" /root/shadowsocks/userapiconfig.py
	sed -i "18c WEBAPI_TOKEN = \'${Mukey}\'" /root/shadowsocks/userapiconfig.py
	
	bash /root/shadowsocks/stop.sh
	bash /root/shadowsocks/run.sh
	echo "新设置已生效."
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

INSTALL(){
	if [ ! -f /usr/bin/ssr ];then
		wget -O /root/ssr_file.zip "https://github.com/qinghuas/ss-panel-and-ss-py-mu/archive/master.zip"
		unzip /root/ssr_file.zip -d /root;mv /root/ss-panel-and-ss-py-mu-master/* /root
		cp /root/ssr.sh /usr/bin/ssr;chmod 777 /usr/bin/ssr
		rm -rf ssr_file.zip /root/ss-panel-and-ss-py-mu-master /root/picture /root/README.md /root/ssr.sh
		clear;echo "INSTALL DONE,Hellow.";sleep 1
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
# 阿 明 个 人 定 制 版                                             #
####################################################################
#【0】 [安装锐速BBR合集版-94ish.me]                                #
#【1】 [节点对接-1-NimaQu]                                         #
#【2】 [节点对接-2-备份版]                                         #
#【3】 [节点对接设置]                                              #
#【4】 [安装fail2ban]                                              #
#【5】 [卸载阿里云云盾]                                            #
#【6】 [更换镜像源]                                                #
#【7】 [路由跟踪]                                                  #
#【8】 [服务器测速]                                                #
#【9】 [安装纯净系统]                                              #
####################################################################
# [z]重新加载 [x]更新脚本 [c]删除脚本 [v]关于脚本                  #
# ${SERVER_IP_INFO}
####################################################################"
read -p "PLEASE SELECT OPTIONS:" SSR_OPTIONS

clear;case "${SSR_OPTIONS}" in
	0)
	Install_BBR;;
	1)
	Install_ss1_node;;
	2)
	Install_ss2_node;;
	3)
	Install_fail2ban;;
	4)
	Edit_ss_node_info
	5)
	Uninstall_ali_cloud_shield;;
	6)
	Change_System_Source;;
	7)
	Routing_track;;
	8)
	Run_Speedtest_And_Bench_sh;;
	9)
	Installation_Of_Pure_System;;
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
