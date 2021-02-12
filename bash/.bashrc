#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically start X on login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec startx;
fi

# Load aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Vim mode for bash
set -o vi

# Bind keys
bind -x '"\C-l": clear'
bind -x '"\C-f": n'

# Local variables
export NNN_OPENER=zathura
export NNN_FALLBACK_OPENER=xdg-open

# Change directory on quit
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
	source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

# Shell depth level
[ -n "$NNNLVL" ] && PS1="(N$NNNLVL) $PS1"
