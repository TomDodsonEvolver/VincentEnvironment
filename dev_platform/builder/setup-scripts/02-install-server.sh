#   Copyright 2016-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
#
#   http://aws.amazon.com/apache2.0/
#
#   or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#!/bin/bash

. $BUILDER_DIR/CONFIG

echostderr "Setting up server environment"

###############
# NGINX
###############
#remove the nginx conf since we need to install nginx first
echostderr "Installing nginx"
rm -rf /etc/nginx/

apt-get install -y nginx

####################
# NODE
####################
echostderr "Installing node"
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
apt-get install -y build-essential
npm install -g npm
