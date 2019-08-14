#!/bin/bash

Install_v2ray(){
	bash <(curl -s -L https://git.io/v2ray.sh)
}

Install_ssr(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssrmu.sh && chmod +x ssrmu.sh && bash ssrmu.sh
}

Install_bbr_1(){
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

Install_ss3_node(){
	yum install wget -y && wget https://raw.githubusercontent.com/SuicidalCat/Airport-toolkit/master/ssr_node_c7.sh && chmod +x ssr_node_c7.sh && ./ssr_node_c7.sh
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

Routing_track(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/yyyyy1412/zmou/master/traceroute.sh && chmod +x traceroute.sh && bash traceroute.sh
}

Run_Speedtest(){
	wget -qO- bench.sh | bash
}

Install_System(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/yyyyy1412/zmou/master/reinstall.sh && chmod +x reinstall.sh && bash reinstall.sh
}

Install_sshpor(){
	wget https://www.moerats.com/usr/down/sshport.sh
	bash sshport.sh
}

REINSTALL(){
	bash sssss.sh
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

GET_NODE_SH_FILE(){
	if [ ! -f /root/node.sh ];then
		wget "https://dl.52ll.org/node.sh";chmod 777 node.sh
	else
		echo "node.sh 已存在."
	fi
}

GET_SERVER_IP

echo "####################################################################
# 阿 明 个 人 定 制 版                                             #
####################################################################
# [1] [锐速BBR合集版-94ish.me]                                     #
# [2] [节点对接-NimaQu]                                            #
# [3] [节点对接-大猫猫版]                                           #
# [4] [节点对接-备份版]                                            #
# [5] [节点对接设置]                                               #
# [6] [服务器测速]                                                 #
# [7] [安装纯净系统]                                               #
# [8] [修改SSH端口]                                                #
####################################################################
# [v] [V2ray一键脚本-https://233now.com/post/1/]                   #
# [s] [SS(R)一键脚本-https://github.com/yyyyy1412/doubi#ssrsh]     # 
####################################################################
# ${SERVER_IP_INFO}
####################################################################"
read -p "PLEASE SELECT OPTIONS:" SSR_OPTIONS

clear;case "${SSR_OPTIONS}" in
	1)
	Install_bbr_1;;
	2)
	Install_ss1_node;;
	3)
	Install_ss3_node;;
	4)
	Install_ss2_node;;
	5)
	Edit_ss_node_info;;
	6)
	Run_Speedtest;;
	7)
	Install_System;;
	8)
	Install_sshpor;;
	v)
	Install_v2ray;;
	s)
	Install_ssr;;
	node)
	GET_NODE_SH_FILE;;
	*)
	echo "选项不在范围内,2s后将重新加载,请注意选择...";sleep 2
	REINSTALL;;
esac

#END 2018-01-02 13:24
