#!/bin/bash -xe

source aws_config.sh

cd dev_platform
packer validate custom_platform.json

