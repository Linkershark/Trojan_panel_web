#!/bin/bash
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

change_panel(){
if test -s /etc/systemd/system/trojan-web.service; then
	green " "
	green " "
	green "================================="
	 blue "  Layanan panel Trojan terdeteksi, mulai konfigurasi"
	green "================================="
	sleep 2s
	$systemPackage update -y
	$systemPackage -y install nginx unzip curl wget
	systemctl enable nginx
	systemctl stop nginx
if test -s /etc/nginx/nginx.conf; then
	rm -rf /etc/nginx/nginx.conf
  wget -P /etc/nginx https://raw.githubusercontent.com/V2RaySSR/Trojan_panel_web/master/nginx.conf
	green "================================="
	blue "     Input Your Domain :"
	green "================================="
	read your_domain
  sed -i "s/localhost/$your_domain/;" /etc/nginx/nginx.conf
	green " "
	green "================================="
	 blue "    Mulai Menginstall Paket "
	green "================================="
	sleep 2s
	rm -rf /usr/share/nginx/html/*
	cd /usr/share/nginx/html/
	wget https://github.com/V2RaySSR/Trojan/raw/master/web.zip
	unzip web.zip
	green " "
	green "================================="
	blue "   mulai konfigurasi trojan-web"
	green "================================="
	sleep 2s
  sed -i '/ExecStart/s/trojan web -p 81/trojan web/g' /etc/systemd/system/trojan-web.service
  sed -i '/ExecStart/s/trojan web/trojan web -p 81/g' /etc/systemd/system/trojan-web.service
  systemctl daemon-reload
  systemctl restart trojan-web
  systemctl restart nginx
  green " "
  green " "
  green " "
	green "=================================================================="
	green " "
	 blue "  WIN / MAC Unduhan klien umum, pengenalan lebih lanjut untuk skrip ini "
	 blue "  https://www.v2rayssr.com/trojanpanel.html "
	green " "
	 blue "  Skrip Grup Telegram AC：https://goii.cc/tg"
	green " "
	 blue "  Direktori situs palsu /usr/share/nginx/html "
	 blue "  url Trojan-panel: http://$your_domain:81 "
	green "=================================================================="
else
	green "==============================="
	  red "     Nginx Tidak Terinstall"
	green "==============================="
	sleep 2s
	exit 1
fi
else
	green "==============================="
	  red " Panel Trojan Tidak Terdeteksi"
	green "==============================="
	sleep 2s
	exit 1
fi
}

bbr_boost_sh(){
    $systemPackage install -y wget
    wget -N --no-check-certificate -q -O tcp.sh "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && bash tcp.sh
}

trojan_install(){
    $systemPackage install -y curl
		source <(curl -sL https://git.io/trojan-install)
}

start_menu(){
  clear
	green "=========================================================="
   blue " 本脚本支持：Debian9+ / Ubuntu16.04+ / Centos7+"
	 blue " 网站：www.v2rayssr.com （已开启禁止国内访问）"
	 blue " YouTube频道：波仔分享"
	 blue " 本脚本禁止在国内任何网站转载"
	green "=========================================================="
   blue " 简介：一键更改 Trojan-Panel 面板端口并设置伪装站点"
	green "=========================================================="
	  red " 运行本脚本之前请确认已经安装Jrohy大神的面板程序"
	green "=========================================================="
	 blue " 1. Jrohy大神的 Trojan 多用户管理部署程序"
   blue " 2. 更改 Trojan 面板端口并设置伪装站点"
   blue " 3. 安装 BBRPlus4 合一加速"
   blue " 0. 退出脚本"
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
		trojan_install
		;;
		2)
		change_panel
		;;
		3)
		bbr_boost_sh
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "请输入正确数字"
	sleep 2s
	start_menu
	;;
    esac
}

start_menu
