#!/bin/bash

if [ -z "$1" ]; 
then 
    echo "Argument must be one of [fm|gs|dev]"
    exit
fi

echo "Deploying $1 environment..."

cd nginx
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp conf.d/* /etc/nginx/conf.d/
sudo cp sites-enabled/*$1* /etc/nginx/sites-enabled/
sudo cp ssl/*$1* /etc/nginx/ssl/


