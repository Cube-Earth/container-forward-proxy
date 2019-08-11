#!/bin/sh
sed -i'' -e "s/^\\(cache_dir [a-z]\\+ [^ ]\\+ \)\\([0-9]\\+\\)/\\1${CACHE_SIZE:-10000}/" /etc/squid/squid.conf
if [[ -z "$(ls -A /cache)" ]]
then
	echo "initializing cache ..."
	squid -Nz
fi

cat /etc/squid/squid.conf | grep https_port

echo "starting squid ..."
squid -NYCd 1
