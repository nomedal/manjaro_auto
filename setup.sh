#!/bin/bash

function packages_base() {
    echo "enable aur for pamac"
    sudo sed -i "s/#EnableAUR/EnableAUR/g" /etc/pamac.conf


    yes | sudo pacman -Syu \
#        git \
#        i3-gaps \
#        i3lock \
#        thunar \
#        lxappearance \
#        rofi \
#        git \
#        gnome-2048 \
#        go \
#        zsh \
#        i3status \
#        autorandr \
#        compton \
#        polybar

    pamac install \
    	# pdfsam
       # latte-dock \
#        discord \
#        nordvpn-bin \
#        dropbox \
#        spotify \
#        insomnia \
#        visual-studio-code-bin
#        dropbox
}

packages_base