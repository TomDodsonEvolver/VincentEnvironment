#!/bin/bash -xe

source aws_config.sh

cd custom_platform
ebp create $@

