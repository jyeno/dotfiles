# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jeno/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias mpv="mpv --gpu-context=wayland"
alias gall="git add --all"
alias gcom="git commit"
alias gs="git status"
alias gck="git checkout"
alias q="exit"
alias m="make"
alias sm="sudo make install"
alias icat="kitty +kitten icat"
alias clima="curl http://pt.wttr.in"
alias v="nvim"
alias vim="nvim"
alias mpdris="systemctl --user start mpd-mpris"

c() {
	if [ $# -eq 0 ];then
		clear
	elif [ -f $1 ]; then
		cat $1
	elif [ -d $1 ]; then
		cd $1
	fi
}
