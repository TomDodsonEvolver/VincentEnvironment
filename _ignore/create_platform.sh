#!/bin/bash -xe

source aws_config.sh

cd dev_platform
ebp create $@

