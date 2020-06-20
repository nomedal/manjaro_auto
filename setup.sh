#!/bin/bash

function packages_base() {
    echo "enable aur for pamac"
    sudo sed -i "s/#EnableAUR/EnableAUR/g" /etc/pamac.conf


    yes | sudo pacman -Syu \

    pamac install \
    	pdfsam \
       	latte-dock \
       	discord \
       	nordvpn-bin \
      	dropbox \
       	spotify \
}

packages_base