#   Copyright 2016-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
#
#   http://aws.amazon.com/apache2.0/
#
#   or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#!/bin/bash

. $BUILDER_DIR/CONFIG

echostderr "Setting up development environment"

##################
# RABBIT
#################
echo "Installing RabbitMQ"
apt-get install -y rabbitmq-server
rabbitmq-plugins enable rabbitmq_management

##rabbitmqctl add_user vincent simian#symposium
#rabbitmqctl delete_user guest
#rabbitmqctl set_permissions vincent ".*" ".*" ".*"

#################
# Mongo
#################
echostderr "Installing Mongo"

# i have no idea how this config file gets here, but it causes the install to fail
rm -f /etc/mongod.conf

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-3.4.list
apt-get update
apt-get install -y mongodb-org
echostderr "GREP: `cat /etc/group | grep mongo`"

echostderr "Creating Mongo keys"

mkdir /etc/mongodb
chmod -R 644 /etc/mongodb
cd /etc/ssl
openssl req -newkey rsa:2048 -new -x509 -days 365 -nodes -subj "/C=US/ST=Pennsylvania/L=Philadelphia/O=Idea Evolver/CN=." -out /etc/mongodb/ca.pem -keyout /etc/mongodb/mongodb-cert.key
cd /etc/mongodb/
cat mongodb-cert.key ca.pem > mongodb.pem
chmod -R 755 /etc/mongodb

echostderr "Importing minimal development database"

cp $BUILDER_DIR/platform-uploads/etc/mongod.conf /etc/mongod.conf

chown mongodb.mongodb /etc/mongod.conf
chown -R mongodb.mongodb /var/log/mongodb
chown -R mongodb.mongodb /var/lib/mongodb

/usr/bin/mongod --fork --config /etc/mongod.conf
mongorestore --host localhost --ssl --sslPEMKeyFile /etc/mongodb/mongodb.pem --sslAllowInvalidCertificates $BUILDER_DIR/mongo_dev_db
/usr/bin/mongod --shutdown --config /etc/mongod.conf

chown -R mongodb.mongodb /var/log/mongodb
chown -R mongodb.mongodb /var/lib/mongodb

systemctl enable mongod.service
