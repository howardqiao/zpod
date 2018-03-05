echo SARTING AP...
sudo ifdown wlan0
sudo cp /etc/network/interfaces.ap /etc/network/interfaces
sudo cp /etc/dhcpcd.conf.ap /etc/dhcpcd.conf
sudo cp /etc/hostapd/hostapd.conf.ori /etc/hostapd/hostapd.conf
sudo cp /usr/sbin/hostapd-ori /usr/sbin/hostapd
sudo systemctl restart dhcpcd
sudo ifup wlan0
sudo systemctl enable hostapd
sudo systemctl start hostapd
sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
sudo systemctl restart upmpdcli
sudo systemctl restart shairport-sync
echo OK!
