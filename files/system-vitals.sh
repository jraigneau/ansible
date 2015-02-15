#!/bin/bash
load=`cat /proc/loadavg | awk '{print $2}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//g'`
memory_free=`free -m | awk '/\-\/\+ buffers\/cache/ { print $4 }'`
memory_total=`free -m | awk '/Mem/ {print $2}'`
mem=$(echo "scale=4; (1-$memory_free/$memory_total)*100" | bc | awk '// { printf("%3.1f", $1) }')
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f", $3/$2*100) }'`
users=`users | wc -w`
curl "http://192.168.1.28/emoncms/api/post.json?apikey=648e893734a8e732f1814cc13b9bc063&node={{ node }}&json={load:$load,root_usage:$root_usage,mem:$mem,swap_usage:$swap_usage,users:$users}"
curl -H "Accept: application/json" -H "Content-Type:application/json" -d '{ "auth_token":"Dash123456", "items": [{"label": "Load", "value": "'"$load"'"}, {"label": "Disk", "value": "'"$root_usage"'%"},{"label": "Mem", "value": "'"$mem"'%"},{"label": "Swap", "value": "'"$swap_usage"'%"},{"label": "Users", "value": "'"$users"'"}] }' http://domify.zeneffy.fr/widgets/{{ hosts }}
