#!/bin/sh
# Run nmcli dev status and filter for wifi type
wifi_info=$(nmcli dev status | grep "wifi " | grep "connected")

if [ -n "$wifi_info" ]; then
  # Using awk to extract fields
  connection=$(echo "$wifi_info" | awk '{print $4}')

  icon=""
  status="Connected to ${connection}"
else
  icon="睊"
  status="offline"
fi

echo "{\"icon\": \"${icon}\", \"status\": \"${status}\"}"
