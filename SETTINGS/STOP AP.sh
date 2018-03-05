echo STOPPING AP...
sudo systemctl stop hostapd
sudo systemctl disable hostapd
sudo systemctl stop dnsmasq
sudo systemctl disable dnsmasq
sudo ifdown wlan0
sudo cp /etc/network/interfaces.ori /etc/network/interfaces
sudo cp /etc/dhcpcd.conf.ori /etc/dhcpcd.conf
sudo systemctl restart dhcpcd
sudo ifup wlan0
sudo systemctl restart upmpdcli
sudo systemctl restart shairport-sync
echo OK!
