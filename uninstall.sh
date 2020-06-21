#!/bin/bash 

if [ -a backup/	 ]
	then
		rm ~/.bashrc
		cp backup/.bashrc ~/
fi

source ~/.bashrc
