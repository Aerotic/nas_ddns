/app/$Script.sh
echo "$Time /app/$Script.sh" > /etc/crontabs/root
crond -f
