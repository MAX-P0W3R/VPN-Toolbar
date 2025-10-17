#!/bin/bash

# Fetch current public IP from within KALI
CURRENT_IP=$(curl -s https://api.ipify.org)

# List of know IPs when VPN is not active
REAL_IPS=("1.2.3.4" "5.6.7.8") # Replace with your real IPs

# Check if current IP is in the list of non-VPN IP(s)
if [[ " ${REAL_IPS[@]} " =~ " ${CURRENT_IP} " ]]; then
    echo "<txt><span foreground='red'>VPN: OFF</span></txt>"
    echo "<tool>Real IP Detected: $CURRENT_IP</tool>"
else
    echo "<txt><span foreground='green'>VPN: $CURRENT_IP</span></txt>"
    echo "<tool>VPN IP Detected: $CURRENT_IP</tool>"
fi
