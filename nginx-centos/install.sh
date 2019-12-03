#!/usr/bin/bash

yum install gcc-c++ -y

tar zxvf openssl-fips-2.0.10.tar.gz
tar zxvf nginx-1.15.5.tar.gz
tar zxvf pcre-8.40.tar.gz
tar zxvf zlib-1.2.11.tar.gz

cd openssl-fips-2.0.10
./config && make && make install

cd ../zlib-1.2.11
 ./configure && make && make install

	
cd ../pcre-8.40
./configure && make && make install

	
cd ../nginx-1.15.5
./configure && make && make install

echo -e "[Unit]\nDescription=nginx - high performance web server\nAfter=network.target remote-fs.target nss-lookup.target\n[Service]\nType=forking\nExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf\nExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf\nExecReload=/usr/local/nginx/sbin/nginx -s reload\nExecStop=/usr/local/nginx/sbin/nginx -s stop\nExecQuit=/usr/local/nginx/sbin/nginx -s quit\n[Install]\nWantedBy=multi-user.target" >/usr/lib/systemd/system/nginx.service

chmod 754 /usr/lib/systemd/system/nginx.service
systemctl daemon-reload
