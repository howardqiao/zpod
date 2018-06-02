#!/bin/bash
echo "] START AP ["
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
if [ -f "/etc/dhcpcd.conf" ]; then
	IN_DHCPCD=$(cat /etc/dhcpcd.conf | grep wlan0)
        if [ -z "$IN_DHCPCD" ]; then
                sudo cat << EOF >> /etc/dhcpcd.conf
interface wlan0
    static ip_address=192.168.20.1/24
EOF
	fi
fi
sudo cp /usr/sbin/hostapd-ori /usr/sbin/hostapd
sudo systemctl enable dhcpcd hostapd dnsmasq
sudo systemctl start dhcpcd hostapd dnsmasq
sudo systemctl restart networking
echo "] Reboot now! ["
reboot
