#!/bin/bash

MONITOR_DEVICE=wlan0
OUTPUT_DEVICE=eth0

# Catch ctrl c so we can exit cleanly
trap ctrl_c INT
function ctrl_c(){
    echo Killing processes..
    service dnsmasq stop
    service hostapd stop
}

ifconfig $MONITOR_DEVICE 10.0.0.1/24 up

echo Configuring IPTables...
iptables -t nat -F
iptables -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
echo '1' > /proc/sys/net/ipv4/ip_forward

#iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000
#iptables -t nat -A PREROUTING -p udp --destination-port 53 -j REDIRECT --to-port 53

echo Starting services...
service dnsmasq start
echo "dnsmasq started!"
service hostapd start
echo "hostapd started!"

echo Starting sniffing...
tshark -i $MONITOR_DEVICE  -w output.pcap -P
