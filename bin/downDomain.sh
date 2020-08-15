#!/bin/sh

mkdir -p ~/sites/$1
cd ~/sites
wget --no-parent \
	 --no-clobber \
	 --recursive \
	 --convert-links \
   	 --html-extension \
	 --page-requisites \
	$1

notify-send "download of the domain ended"
