#!/bin/sh

# IP address of the lamp
lamp_ip="192.168.18.14"
port=38899

# Turn off the lamp by setting dimming to 0
echo -n "{\"id\":1,\"method\":\"setState\",\"params\":{\"state\":false}}" | ncat -u -w 1 $lamp_ip $port
