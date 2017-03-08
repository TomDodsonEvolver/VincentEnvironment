#!/bin/bash

. $BUILDER_DIR/CONFIG

###############
# PYTHON
###############
echostderr "Setting up Python virtual environment"

echostderr "Installing build dependeicnies"
apt-get install -y python-pip libxml2-dev libxslt-dev libjpeg-dev libz-dev
pip install --upgrade pip
pip install --upgrade virtualenv
apt-get install -y autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib libbluetooth-dev libbz2-dev \
     libexpat1-dev libffi-dev libffi6  libffi6-db libgdbm-de libgpm2  libncurses libreadlin libsqlite3 libssl-dev \
     libtinfo-d mime-suppo net-tools netbase python-cry python-mox python-pil python-ply quilt tk-dev zlib1g-dev

echostderr "Building Python"

wget https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
tar xfz Python-2.7.13.tgz
cd Python-2.7.13/
./configure --prefix /usr/local/lib/python2.7.13 --enable-ipv6
make && make install

echostderr "Python version is:"
echostderr `/usr/local/lib/python2.7.13/bin/python -V`

echostderr "Creating virutal environment $PYTHON_VENV in $PYTHON_VENV_DIR"
mkdir -p $VENV_DIR
cd $VENV_DIR
virtualenv --python=/usr/local/lib/python2.7.13/bin/python $PYTHON_VENV

echostderr "Moving into virutal envionrment"
source $PYTHON_VENV_DIR/bin/activate
echostderr "Python version is:"
echostderr `python -V`

echostderr "Installing dependencies via pip"
# have to install this first to avoid circular dependencies
pip install pytz==2015.4
pip install -r requirements.txt
