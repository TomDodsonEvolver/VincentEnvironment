#!/bin/bash -xe

source aws_config.sh

cd custom_platform
packer validate custom_platform.json

