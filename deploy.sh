#!/bin/bash

BASE_DIR=~/VincentEnvironment

if [ -z "$1" ]; 
then 
    echo "Argument must be one of [fm|gs|dev]"
    exit
fi

echo "Deploying $1 environment..."

##########
# NGINX
#########
echo "Deploying nginx"
cd nginx
cp nginx.conf /etc/nginx/nginx.conf
cp conf.d/* /etc/nginx/conf.d/
cp sites-enabled/*$1* /etc/nginx/sites-enabled/

if [ "$1" != "dev" ];
then
	cp ssl/*$1* /etc/nginx/ssl/
fi

chmod 755 /etc/nginx/conf.d
chmod 644 /etc/nginx/nginx.conf
chown -R root.root /etc/nginx/

#reload config files and resatrt the service
service nginx reload
service nginx restart

