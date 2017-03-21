#!/bin/bash

echo
echo "!!!!!!!!!!!!!HERE BE DRAGONS!!!!!!!!!!!!!!"
echo
echo "Warning! This will destroy your current VM!"
echo "     You should back up your local database first"
echo
read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
    START=`pwd`
    cd packer/dev_platform/
    packer build dev_1604_platform.json
    vagrant destroy --force
    vagrant box add --name vincent.dev --force vincent_dev.box
    vagrant up
fi
