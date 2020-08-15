#!/bin/sh
export LANG=C

if [ $(tty) = /dev/tty1 ]; then

	# LD_LIBRARY_PATH only needed if you are building without rpath
	# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

	export XDG_DATA_DIRS=/usr/local/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
	export XDG_CONFIG_DIRS=/usr/local/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}
	export XDG_CURRENT_DESKTOP=KDE
	export QT_PLUGIN_PATH=/usr/local/lib/plugins:$QT_PLUGIN_PATH
	
	# keyboard related
	export XKB_DEFAULT_LAYOUT="br"
	export XKB_DEFAULT_VARIANT="abnt2"
	export XKB_DEFAULT_OPTIONS="ctrl:nocaps"

	# wayland related
	export QT_QPA_PLATFORM=wayland-egl
	export CLUTTER_BACKEND=wayland
	export SDL_VIDEODRIVER=wayland
	export BEMENU_BACKEND=wayland
	export MOZ_ENABLE_WAYLAND=1

	exec sway

elif [ $(tty) = /dev/tty2 ]; then
	exec startx
fi

