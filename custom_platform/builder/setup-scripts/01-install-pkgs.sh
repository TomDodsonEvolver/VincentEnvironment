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
yum -y install git gcc libxml2-devel libxslt-devel libjpeg-devel zlib-devel >/dev/null

pip install --upgrade pip

#have to install this first to avoid circular dependencies
/usr/local/bin/pip install pytz==2015.4 >/dev/null
/usr/local/bin/pip install -r $BUILDER_DIR/requirements.txt >/dev/null

###############
# NGINX
###############
#remove the nginx conf since we need to install nginx first
echo "Installing nginx"
#yum -y install nginx >/dev/null

rsync -ar $BUILDER_DIR/platform-uploads/etc/nginx/ /etc/nginx/
chmod 755 /etc/nginx/conf.d
chmod 644 /etc/nginx/nginx.conf
chown -R root.root /etc/nginx/

####################
# SUPERVISOR
####################
echo "Installing supervisor"
/usr/local/bin/pip install supervisor >/dev/null

rm -rf /etc/supervisor
mkdir -p /etc/supervisor/
rsync -ar $BUILDER_DIR/platform-uploads/etc/supervisor/ /etc/supervisor/
chmod -R 644 /etc/supervisor/
chown -R root.root /etc/supervisor/

cp $BUILDER_DIR/platform-uploads/etc/init.d/supervisor /etc/init.d/supervisor
chmod 755 /etc/init.d/supervisor
chown root.root /etc/init.d/supervisor

mkdir -p /var/log/supervisor
chown root.root /var/log/supervisor

####################
# NODE
####################
echo "Installing node"
curl -X GET -o RPM-GPG-KEY-lambda-epll https://lambda-linux.io/RPM-GPG-KEY-lambda-epll
sudo rpm --import RPM-GPG-KEY-lambda-epll
curl -X GET -o epll-release-2016.09-1.2.ll1.noarch.rpm https://lambda-linux.io/epll-release-2016.09-1.2.ll1.noarch.rpm
sudo yum -y install epll-release-2016.09-1.2.ll1.noarch.rpm
sudo yum --enablerepo=epll-preview -y install nodejs6

##################
# RABBIT
#################
sudo yum -y install rabbitmq-server --enablerepo=epel
