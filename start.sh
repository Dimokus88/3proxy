#!/bin bash

apt-get -y update && apt-get -y upgrade
apt-get install -y sudo make build-essential git
git clone https://github.com/3proxy/3proxy.git
cd 3proxy
sudo make -f Makefile.Linux
cp ./bin/3proxy /usr/bin
