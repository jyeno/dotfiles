#!/bin/sh

# exports are in zshenv file
if [ $(tty) = /dev/tty1 ]; then
	sway
fi

