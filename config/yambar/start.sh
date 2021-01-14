#!/usr/bin/sh

pkill -9 yambar

yambar -c ~/.config/yambar/main.conf >> ~/.config/yambar/log 2>&1 &
