#!/bin/bash

function packages_base() {
	echo "==> package setup initated"
    echo "  -> enableing aur for pamac"
    sudo sed -i "s/#EnableAUR/EnableAUR/g" /etc/pamac.conf


    yes | sudo pacman -Syu \

    pamac install \
    	clonezilla \
    	zsh \
    	pyenv \
    	thunderbird \
    	qbittorrent \
    	pdfsam \
       	latte-dock \
       	discord \
       	nordvpn-bin \
       	visual-studio-code-bin \
       	virt-manager \
       	slack-desktop \
       	sublime-text-3-imfix \
       	wondershaper-git \
       	libvirt \
       	virt-manager \
       	ovmf \
       	qemu \
       	dnsmasq \
       	ebtables \
       	iptables \
       	arduino \
       	gparted \
       	caprine \
       	signal-desktop \
		
		# packages for tinyfpga
		#icestorm-git \
		#arachne-pnr-git \
		#yosys-git \
       	
		# temporarily broken packages
       	#spotify \
       	#dropbox \
       	#balena-etcher \
       	#musixmatch-bin \

   	echo "==> DONE"
}

function git_setup() {

	echo "==> git setup initiated"

	user_input=0
	while [ $user_input != "y" ]; do
					echo "Enter git user email:"
					read user_email
					echo "Is this the correct email? [y/n]"
					read user_input				
	done

	echo "  -> Using git user email: $user_email"

	ssh-keygen -t rsa -b 4096 -C "$user_email"

	echo "  -> Starting ssh agent"
	eval "$(ssh-agent -s)"

	echo "  -> Adding ssh-key to ssh-agent"
	ssh-add ~/.ssh/id_rsa

	key=`cat ~/.ssh/id_rsa.pub`

	user_input=0
	while [ $user_input != "y" ]; do

					echo "Enter git username:"
					read user_name
					echo "Is this the correct username? [y/n]"
					read user_input				
	done

	user_input=0
	while [ $user_input != "y" ]; do
					echo "Enter ssh-key title:"
					read ssh_title
					echo "Is this the correct ssh-key title? [y/n]"
					read user_input				
	done
	
	curl -u "$user_name" --data "{\"title\":\"$ssh_title\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
	echo "==> DONE"
}

function disclaimer() {

	echo "==> This is an automatic setup that installs packages/programs" \
			"and configures git. Note that you have full control over" \
			"what is installed by editing the setup.sh file. If this" \
			"is your first setup, there is much to be learned by" \
			"having to read up on documentation and guides, to set" \
			"things up yourself."

	echo "Press enter to continue:"

	chars="/-\|"

	while true; do
	  for (( i=0; i<${#chars}; i++ )); do
	    sleep 0.5
	    echo -en "${chars:$i:1}" "\r"
	  done
	done &
  	read
  	kill $!
}

function zsh_setup() {
	echo "==> zsh_setup initated"
	sudo chsh -s /usr/bin/zsh

	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	echo "==> DONE"
}

function reboot() {
	read -n1 -p "  -> For changes to take effect, you should reboot. Do it now? [y/n]" doit 
	case $doit in  
	  y|Y)  sudo shutdown now -r;; 
	  n|N) printf "\n==> SETUP COMPLETE";; 
	esac
}

#disclaimer
packages_base
#git_setup
#zsh_setup
#reboot
