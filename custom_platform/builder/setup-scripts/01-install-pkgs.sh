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
yum -y install python2.7 python-pip python-dev libxml2-dev libxslt-dev libjpeg-dev libz2-dev >/dev/null

#have to install this first to avoid circular dependencies
pip install pytz==2015.4
pip install -r requirements.txt

###############
# NGINX
###############
#remove the nginx conf since we need to install nginx first
echo "Installing nginx"
rm -rf /etc/nginx/

yum -y install nginx >/dev/null

rsync -ar $BUILDER_DIR/platform-uploads/etc/nginx/ /etc/nginx/
chmod 755 /etc/nginx/conf.d
chmod 644 /etc/nginx/nginx.conf
chown -R root.root /etc/nginx/

chkconfig nginx on

####################
# SUPERVISOR
####################
echo "Installing supervisor"
yum -y install supervisor >/dev/null

####################
# NODE
####################
echo "Installing node"
curl -sL https://deb.nodesource.com/setup_6.x | bash - >/dev/null
yum -y install nodejs >/dev/null
yum -y install build-essential >/dev/null


##################
# RABBIT
#################
yum -y install rabbitmq-server >/dev/null



