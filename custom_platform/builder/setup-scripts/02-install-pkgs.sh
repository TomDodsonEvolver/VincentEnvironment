#   Copyright 2016-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
#
#   http://aws.amazon.com/apache2.0/
#
#   or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#!/bin/bash

. $BUILDER_DIR/CONFIG

###############
# NGINX
###############
#remove the nginx conf since we need to install nginx first
echostderr "Installing nginx"
rm -rf /etc/nginx/

apt-get install -y nginx

rsync -ar $BUILDER_DIR/platform-uploads/etc/nginx/ /etc/nginx/
chmod 755 /etc/nginx/conf.d
chmod 644 /etc/nginx/nginx.conf
chown -R root.root /etc/nginx/

####################
# SUPERVISOR
####################
echostderr "Installing supervisor"
apt-get install -y supervisor

####################
# NODE
####################
echostderr "Installing node"
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
apt-get install -y build-essential


##################
# RABBIT
#################
echostderr "Installing Rabbit"
apt-get install -y rabbitmq-server

#################
# Mongo
#################
echostderr "Installing Mongo"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-3.4.list
apt-get update
apt-get install -y mongodb-org
service mondgod start

