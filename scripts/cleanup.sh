#!/bin/bash

yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all
sudo rm -rf /root/VBoxGuestAdditions_*.iso
sudo rm -rf /tmp/rubygems-*
