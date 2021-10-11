# things that are good to add later on:
### direnv

# Colors and vars
GREEN='\033[32;01m'
YELLOW='\033[33;01m'
RED='\033[1;31m'
BLUE='\033[34;01m'
PURPLE='\033[35m'
NORMAL='\033[0m'

_tab() {
    if [ $TAB ]; then
        echo "$YELLOW$TAB "
    fi
}
git_info() {
    local exit=$?
    local pcmode=no
    local detached=no
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch="$(git branch | grep '*')"
        local status="$(git status --porcelain | sed '/??/d')"
        local untracked="$RED$(git status --porcelain | sed '/??/!D;/build/d;/.cache/d' | cut -b 1 | uniq | tr '?' '#')"
        local staged=""

        [ -n "$(echo ${status%% *} | tr -d '\n')" ] && isstaged=true || isstaged=false
        [ -n "$(echo "$status" | cut -d' ' -f2 | tr -d '\n')" ] && isunstaged=true || isunstaged=false

        if [ "$isstaged" = true ] && [ "$isunstaged" = true ]; then
            staged="$GREEN+$YELLOW%% "
        elif [ "$isstaged" = true ] && [ "$isunstaged" = false ]; then
            staged="$GREEN+ "
        elif [ "$isstaged" = false ] && [ "$isunstaged" = true ]; then
            staged="$YELLOW%% "
        else
            staged=""
        fi
        printf "$PURPLE${branch##* } ${untracked}${staged}"
    fi
}

get_exit() {
    [ "$?" = 0 ] && printf "$GREEN" || printf "$RED"
}

# simple quotes to make git verification work, may need to adapt to others shells
PS1='$(printf $BLUE)\w $(git_info)\n$(_tab)$(get_exit)>$(printf $NORMAL) '

set -o vi
set -o csh-history
# git autocomplete
set -A complete_git_1 -- \
    add am archive \
    br bisect branch bundle \
    co cip cl checkout cherry-pick citool clean clone commit config \
    d ds describe diff \
    fp fetch format-patch \
    gc grep gui \
    init \
    l log \
    merge mv \
    notes \
    pll psh pull push \
    rb range-diff rebase reset restore revert rm \
    st shortlog show sparse-checkout stash status submodule switch \
    tag \
    worktree

# end git autocomplete

# mpc autocomplete
# set -A complete_mpc_1 -- \
#     add \
#     cdprev channels clear clearerror \
#     consume crop crossfade current \
#     del disable \
#     enable \
#     find findadd \
#     idle idleloop insert \
#     list listall load ls lsplaylists \
#     mixrampdb mixrampdelay move \
#     next \
#     outputs outputset \
#     pause pause-if-playing play playlist prev prio \
#     random repeat replaygain rescan rm \
#     save search searchadd searchplay seek \
#     sendmessage shuffle single stats \
#     sticker stop subscribe \
#     toggle toggleoutput \
#     update \
#     version volume \
#     waitmessage \
# pgrep -fq '/usr/local/sbin/mpd'
# if [ $? = 0 ]; then
#     set -A complete_mpc_2 -- $(mpc lsplaylists 2> /dev/null | sort)
# fi
# end mpc autocomplete

# man autocomplete
# MAN_CACHE="~/.cache/ksh_man_cache"
# if [ ! -f $MAN_CACHE ]; then
#     MANPATH=/usr/share/man man -k man | cut -d\( -f1 | tr -d , | \
#         sort | uniq > $MAN_CACHE
# fi
# set -A complete_man_1 -- $(cat $MAN_CACHE)
# end man autocomplete

HISTSIZE=1000000
HISTFILE=~/.config/ksh/ksh-history

export PS1 HISTSIZE HISTFILE

#aliases
alias \
    mpv="mpv --loop" \
    q="exit" \
    m="make -j8" \
    sm="sudo make install" \
    v="nvim" \
    vim="nvim" \
    sudo="sudo " \
    ls='exa --color-scale --sort=type --group-directories-first' \
    l='exa -l --color-scale --sort=type --group-directories-first' \
    iwds="iwctl station wlan0 show" \
    iwdc="iwctl station wlan0 connect" \
    iwdg="iwctl station wlan0 get-networks" \
    rm="rm -i" \
    reload=". ~/.kshrc" \
    ..="cd .." \
    qtcreator="QT_QPA_PLATFORM=xcb ~/Qt/Tools/QtCreator/bin/qtcreator" \
    # habit="task rc.data.location=~/.config/task/habits" \
    runmonerod="monerod --config-file ~/.config/monerod/monerod.conf --log-file /home/build/.bitmonero/log --pidfile /home/build/.bitmonero/monerod.pid"

#making the life easier
c() {
    if [ $# -eq 0 ];then
        clear
    elif [ -f $1 ]; then
        cat $1
    elif [ -d $1 ]; then
        # workaround for git autocomplete of branchs
        cd $1 && set -A complete_git_2 -- $(git branch 2>/dev/null | sed 's/\*/ /')
    fi
}

# you can put as many files do you want
0x0() {
for i in "$@"; do
    curl -F file=@$i http://0x0.st
done
}

# fzf select music from mpd playlist
fmpc() {
    local song_position
    song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
        fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
        sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
            [ -n "$song_position" ] && mpc -q play $song_position
}

# download file based on the clipboard
down() {
    aria2c "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

# play video based on the clipboard
play() {
    if [ "$#" = 0 ]; then
        mpv "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
    else
        mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
    fi
}

# making the life easier and avoiding typing always the password of ssh key
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ -z "$SSH_AUTH_SOCK" ]]; then
    . "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# echo "$RED PENDING $NORMAL\n"
# echo "================== TO-DOs =================="
# task next 2>/dev/null
# echo "\n================== HABITS =================="
# habit next 2>/dev/null
