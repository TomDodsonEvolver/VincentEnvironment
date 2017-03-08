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
echo "Installing Python"
apt-get install -y python2.7 python-pip python-dev libxml2-dev libxslt-dev libjpeg-dev libz-dev >/dev/null

#have to install this first to avoid circular dependencies
pip install pytz==2015.4
pip install -r $BUILDER_DIR/requirements.txt

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
echo "Installing RabbitMQ"
apt-get install -y rabbitmq-server >/dev/null



