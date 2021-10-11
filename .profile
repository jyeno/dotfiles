#!/bin/env sh

export ENV="$HOME/.kshrc"
export EDITOR="nvim"
export PATH=$HOME/bin:$HOME/.bin/:$HOME/.local/bin/:$HOME/.cargo/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH
export GPG_TTY=$(tty)

# keyboard related
export XKB_DEFAULT_LAYOUT="workman"
export XKB_DEFAULT_VARIANT="trabalhador"
export XKB_DEFAULT_OPTIONS="ctrl:nocaps"

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

if [ $(tty) = /dev/tty1 ]; then

    # Native display
    export BEMENU_BACKEND='wayland'
    export MOZ_ENABLE_WAYLAND=1
    export SAL_USE_VCLPLUGIN='gtk3'
    export GDK_BACKEND='wayland'
    export XDG_SESSION_TYPE='wayland'
    export QT_QPA_PLATFORM='wayland'
    #export QT_WAYLAND_FORCE_DPI='physical'
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export CLUTTER_BACKEND='wayland'
    # export SDL_VIDEODRIVER='wayland'
    export ECORE_EVAS_ENGINE='wayland_egl'
    export ELM_ENGINE='wayland_egl'
    #export GTK_USE_PORTAL=1

    # Bug Fixing
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=0

    # NO NVIDIA
    #sudo rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
    #export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json

    # Pipewire
    #export LD_PRELOAD="/usr/lib/libjack-pw.so" "/usr/lib/libpulse-"{pw,mainloop-glib-pw,simple-pw}".so"
    # export AE_SINK=ALSA
    # export SDL_AUDIODRIVER=alsa

    # Telegram
    export TDESKTOP_DISABLE_GTK_INTEGRATION=1

    # Qt appearance
    #requires plasma-integration (could be qt5ct instead)
    # export QT_QPA_PLATFORMTHEME='kde'
    # export QT_PLATFORMTHEME='kde'
    # export QT_PLATFORM_PLUGIN='kde'

    # DE
    export XDG_CURRENT_DESKTOP='sway'
	# LD_LIBRARY_PATH only needed if you are building without rpath
	# export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

	export XDG_DATA_DIRS=/usr/local/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
	export XDG_CONFIG_DIRS=/usr/local/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}
	export QT_PLUGIN_PATH=/usr/local/lib/plugins:$QT_PLUGIN_PATH
	export QML2_IMPORT_PATH=/usr/local/lib/qml:$QML2_IMPORT_PATH

    exec sway > ~/.config/sway/log 2>&1

elif [ $(tty) = /dev/tty2 ]; then

# 	# LD_LIBRARY_PATH only needed if you are building without rpath
 	export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

 	export XDG_DATA_DIRS=/usr/local/share:${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}
 	export XDG_CONFIG_DIRS=/usr/local/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}
 	export QT_PLUGIN_PATH=/usr/local/lib/plugins:$QT_PLUGIN_PATH
 	export QML2_IMPORT_PATH=/usr/local/lib/qml:$QML2_IMPORT_PATH

# 	# wayland related
 	export QT_QPA_PLATFORM=wayland
 	export CLUTTER_BACKEND=wayland
 	export SDL_VIDEODRIVER=wayland
 	export BEMENU_BACKEND=wayland
 	export MOZ_ENABLE_WAYLAND=1

    export XDG_CURRENT_DESKTOP='sway'

 	exec river > ~/.config/river/log 2>&1

elif [ $(tty) = /dev/tty3 ]; then
    XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland
fi
