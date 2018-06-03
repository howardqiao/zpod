#!/bin/bash
echo "] STOP AP! ["
sudo systemctl stop dhcpcd hostapd dnsmasq
sudo systemctl disable dhcpcd hostapd dnsmasq
if [ -f "/etc/dhcpcd.conf" ]; then
	IN_DHCPCD=$(cat /etc/dhcpcd.conf | grep wlan0)
    if [ -n "$IN_DHCPCD" ]; then
		sudo sed -i 's/^[ \t]*interface wlan0.*//g' /etc/dhcpcd.conf
		sudo sed -i 's/^[ \t]*static ip_address.*//g' /etc/dhcpcd.conf
	fi
fi
IN_WPA=$(sudo cat /etc/wpa_supplicant/wpa_supplicant.conf | grep network)
if [ -z "$IN_WPA" ]; then
	if [ -f "/boot/wifikeyfile.txt" ]; then
		sudo echo "network={" >> /etc/wpa_supplicant/wpa_supplicant.conf
		sudo cat /boot/wifikeyfile.txt >> /etc/wpa_supplicant/wpa_supplicant.conf
		sudo echo "}" >> /etc/wpa_supplicant/wpa_supplicant.conf
	fi
fi
sudo systemctl daemon-reload
sudo systemctl enable dhcpcd
sudo systemctl start dhcpcd
sudo systemctl restart networking
echo "] Reboot now! ["
reboot
