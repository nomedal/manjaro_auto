#!/bin/bash

function packages_base() {
	echo "==== package setup initated ===="
    echo "==> enableing aur for pamac"
    sudo sed -i "s/#EnableAUR/EnableAUR/g" /etc/pamac.conf


    yes | sudo pacman -Syu \

    pamac install \
    	clonezilla \
    	pyenv \
    	thunderbird \
    	qbittorrent \
    	pdfsam \
       	latte-dock \
       	discord \
       	nordvpn-bin \
       	dropbox \
       	spotify \
       	insomnia \
       	visual-studio-code-bin \
       	virt-manager \
       	slack-desktop \
       	sublime-text \
       	wondershaper-git
}

function git_setup() {

	echo "==== git setup initiated ===="

	user_input=0
	while [ $user_input != "y" ]; do
					echo "enter git user email:"
					read user_email
					echo "is this the correct email? [y/n]"
					read user_input				
	done

	echo "==> using git user email: $user_email"

	ssh-keygen -t rsa -b 4096 -C "$user_email"

	echo "==> starting ssh agent"
	eval "$(ssh-agent -s)"

	echo "==> adding ssh-key to ssh-agent"
	ssh-add ~/.ssh/id_rsa

	key=`cat ~/.ssh/id_rsa.pub`

	user_input=0
	while [ $user_input != "y" ]; do

					echo "enter git username:"
					read user_name
					echo "is this the correct username? [y/n]"
					read user_input				
	done

	user_input=0
	while [ $user_input != "y" ]; do
					echo "enter ssh-key title:"
					read ssh_title
					echo "is this the correct ssh-key title? [y/n]"
					read user_input				
	done
	
	curl -u "$user_name" --data "{\"title\":\"$ssh_title\",\"key\":\"`cat ~/.ssh/id_rsa.pub`\"}" https://api.github.com/user/keys
}

function disclaimer() {

	echo "==== This is an automatic setup that installs packages/programs" \
			"and configures git. Note that you have full control over" \
			"what is installed by editing the setup.sh file. If this" \
			"is your first setup, there is much to be learned by" \
			"having to read up on documentation and guides, to set" \
			"things up yourself. ===="

	echo "==> press enter to continue"

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

function bashrc_setup() {
	mkdir -p backup	# if dir doen'st exist
	chmod +x uninstall.sh 

	cp ~/.bashrc backup

	echo 'alias multipull="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"' >> ~/.bashrc # exec git pull on all subdirs 
	echo 'alias home="cd ~"' >> ~/.bashrc

	exec bash
}

disclaimer
packages_base
git_setup
bashrc_setup
