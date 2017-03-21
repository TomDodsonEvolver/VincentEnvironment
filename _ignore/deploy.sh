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
cp sites-enabled/*$1* /etc/nginx/sites-enabled/

if [ "$1" != "dev" ];
then
	cp ssl/*$1* /etc/nginx/ssl/
fi

