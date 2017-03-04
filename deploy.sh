#!/bin/bash

if [ -z "$1" ]; 
then 
    echo "Argument must be one of [fm|gs|dev]"
    exit
fi

echo "Deploying $1 environment..."

##########
#NGINX
#########
echo "Deploying nginx"
cd nginx
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp conf.d/* /etc/nginx/conf.d/
sudo cp sites-enabled/*$1* /etc/nginx/sites-enabled/

if [ "$1" != "dev" ];
then
	sudo cp ssl/*$1* /etc/nginx/ssl/
fi

sudo service nginx reload
sudo service nginx restart

