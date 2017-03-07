#   Copyright 2016-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
#
#   http://aws.amazon.com/apache2.0/
#
#   or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#!/bin/bash -xe

. $BUILDER_DIR/CONFIG

yum -y install wget tree

chkconfig --add nginx
chkconfig nginx on

chkconfig --add supervisor
chkconfig supervisor on

chkconfig --add rabbitmq-server
chkconfig rabbitmq-server on

echo "Creating base directories for platform."
mkdir -p /var/www/ideaevolver.com
chown nginx /var/www/ideaevolver.com
chown -R nginx /var/log/nginx/

service nginx start
service rabbitmq-server start
service supervisor start
