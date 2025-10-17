#!/bin/bash
# Genmon VPN status indicator — shows tun0 IP if VPN is active, else real IP

# List of known real (non-VPN) IPs — update these
REAL_IPS=("1.2.3.4" "5.6.7.8")

# Try to get tun0 IPv4 address
TUN_IP=$(ip -4 addr show tun0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1)

# Always get current public IP
CURRENT_IP=$(curl -s --max-time 5 https://api.ipify.org)

if [[ -n "$TUN_IP" ]]; then
    # VPN is active
    echo "<txt><span foreground='green'>VPN: $TUN_IP</span></txt>"
    echo "<tool>VPN Active — tun0 IP: $TUN_IP</tool>"
elif [[ " ${REAL_IPS[@]} " =~ " ${CURRENT_IP} " ]]; then
    # Known real IP detected
    echo "<txt><span foreground='red'>VPN: OFF</span></txt>"
    echo "<tool>Real IP Detected: $CURRENT_IP</tool>"
else
    # tun0 missing but IP not in real list — unknown state
    echo "<txt><span foreground='orange'>VPN: UNKNOWN</span></txt>"
    echo "<tool>Could not verify VPN status — External IP: $CURRENT_IP</tool>"
fi
