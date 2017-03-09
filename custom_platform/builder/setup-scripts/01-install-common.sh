#!/bin/bash

. $BUILDER_DIR/CONFIG

###############
# PYTHON
###############
echostderr "Setting up Python environment"

echostderr "Installing build dependeicnies"
apt-get install -y libxml2-dev libxslt-dev libjpeg-dev libz-dev
#pip install --upgrade pip

echostderr "Installing dependencies via pip"
# have to install this first to avoid circular dependencies
pip install pytz==2015.4
pip install -r $BUILDER_DIR/requirements.txt

####################
# SUPERVISOR
####################
echostderr "Installing supervisor"
apt-get install -y supervisor
