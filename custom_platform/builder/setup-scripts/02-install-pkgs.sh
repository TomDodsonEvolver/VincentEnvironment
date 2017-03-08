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
# PYTHON
###############
echo "Setting up Python virtual environment"
#dependeicnies for requirements
apt-get install -y libxml2-dev libxslt-dev libjpeg-dev libz-dev >/dev/null
sudo apt-get install -y autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib libbluetooth-dev libbz2-dev \
     libexpat1-dev libffi-dev libffi6  libffi6-db libgdbm-de libgpm2  libncurses libreadlin libsqlite3 libssl-dev \
     libtinfo-d mime-suppo net-tools netbase python-cry python-mox python-pil python-ply quilt tk-dev zlib1g-dev


#install requirements
# have to install this first to avoid circular dependencies
pip install pytz==2015.4
pip install -r requirements.txt

###############
# NGINX
###############
#remove the nginx conf since we need to install nginx first
echo "Installing nginx"
rm -rf /etc/nginx/

apt-get install -y nginx >/dev/null

rsync -ar $BUILDER_DIR/platform-uploads/etc/nginx/ /etc/nginx/
chmod 755 /etc/nginx/conf.d
chmod 644 /etc/nginx/nginx.conf
chown -R root.root /etc/nginx/

chkconfig nginx on

####################
# SUPERVISOR
####################
echo "Installing supervisor"
apt-get install -y supervisor >/dev/null

####################
# NODE
####################
echo "Installing node"
curl -sL https://deb.nodesource.com/setup_6.x | bash - >/dev/null
apt-get install -y nodejs >/dev/null
apt-get install -y build-essential >/dev/null


##################
# RABBIT
#################
apt-get install -y rabbitmq-server >/dev/null



