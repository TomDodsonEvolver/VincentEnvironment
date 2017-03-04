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

#tell elastic beanstalk that we're using 
cd /opt/elasticbeanstalk/srv/hostmanager/lib/elasticbeanstalk/hostmanager
cp utils/apacheutil.rb utils/nginxutil.rb
sed -i 's/Apache/Nginx/g' utils/nginxutil.rb
sed -i 's/apache/nginx/g' utils/nginxutil.rb
sed -i 's/httpd/nginx/g' utils/nginxutil.rb

#reload config files and resatrt the service
service nginx reload
service nginx restart

