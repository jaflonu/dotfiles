# Prompt setup
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[green]%}$%b "
setopt autocd
setopt extended_glob
setopt histappend
stty stop undef
#autoload -Uz promptinit
#promptinit
#prompt adam1

# Use Vim keybindings
bindkey -v
KEYTIMEOUT=1

# Writing cli-history
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zhistory

# Loading aliases and shortcuts
[ -f "$HOME/.zaliases" ] && source "$HOME/.zaliases"

# Use modern completion system
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Vim navigation in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Using lf
lfcd() {
		tmp="$(mktemp)"
		lf -last-dir-path="$tmp" "$@"
		if [ -f "$tmp" ]; then
				dir="$(cat "$tmp")"
				rm -f "$tmp" >/dev/null
				[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
		fi
}
bindkey -s '^f' 'lfcd\n'
bindkey -s '^a' 'bc -l\n'
bindkey -s '^o' 'cd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Wake up case-like environments
function wake() {
		case $1 in
				gatsby)
						export NVM_DIR="$HOME/.nvm"
						[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
						[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
						printf "Gatsby is woken.\n"
						;;
				conda)
						__conda_setup="$("~/anaconda3/bin/conda" shell.bash hook 2> /dev/null)"
						if [ $? -eq 0 ]; then
								eval "$__conda_setup"
						else
								if [ -f "$PWD/anaconda3/etc/profile.d/conda.sh" ]; then
										. "$PWD/anaconda3/etc/profile.d/conda.sh"
								else
										export PATH="$PWD/anaconda3/bin:$PATH"
								fi
						fi
						unset __conda_setup
						;;
				*)
						printf "Argument is not recognized.\n"
						;;
		esac
}

# Old default settings
#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
