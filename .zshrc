#!/bin/zsh

# The ZSH configuration.
# Definitions for some commands and modules of preference.

# Prompt setup
autoload -U colors && colors
PS1="%B%{$fg[white]%}[%{$fg[magenta]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[blue]%}%~%{$fg[white]%}]%{$fg[green]%}$%b "
setopt autocd
setopt extended_glob
setopt histappend
stty stop undef
autoload -Uz promptinit
promptinit
#prompt adam1

# Use Vim keybindings
bindkey -v
KEYTIMEOUT=1

# Writing cli-history
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zhistory

# Loading aliases
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

# Using `lf`
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

# Configuration for the `ls` command
LS_COLORS='no=00;37:fi=00:di=38;5;30:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:ex=38;5;208;1:*.md=38;5;220;1:*.markdown=38;5;220;1:*.rst=38;5;220;1:*.tex=38;5;184:*.bib=38;5;178:*.json=38;5;178:*.xml=38;5;178:*.toml=38;5;178:*.yaml=38;5;178:*.yml=38;5;178:*.chm=38;5;141:*.pdf=38;5;141:*.PDF=38;5;141:*.mobi=38;5;141:*.epub=38;5;141:*.doc=38;5;111:*.docx=38;5;111:*.odb=38;5;111:*.odt=38;5;111:*.ppt=38;5;166:*.pptx=38;5;166:*.csv=38;5;78:*.tsv=38;5;78:*.xla=38;5;76:*.ods=38;5;112:*.xls=38;5;112:*.xlsx=38;5;112:*.git=38;5;197:*.gitignore=38;5;240:*.gitattributes=38;5;240:*.gitmodules=38;5;197:*.awk=38;5;172:*.bash=38;5;172:*.bat=38;5;172:*.BAT=38;5;172:*.sed=38;5;172:*.sh=38;5;172:*.zsh=38;5;172:*.vim=38;5;172:*.py=38;5;41:*.ipynb=38;5;41:*.rb=38;5;41:*.gemspec=38;5;41:*.pl=38;5;208:*.PL=38;5;160:*.t=38;5;114:*.msql=38;5;222:*.mysql=38;5;222:*.sql=38;5;222:*.pgsql=38;5;222:*.tcl=38;5;64;1:*.r=38;5;49:*.R=38;5;49:*.clj=38;5;41:*.cljs=38;5;41:*.cljc=38;5;41:*.scala=38;5;41:*.dart=38;5;51:*.cl=38;5;81:*.lisp=38;5;81:*.rkt=38;5;81:*.lua=38;5;81:*.c=38;5;81:*.C=38;5;81:*.h=38;5;110:*.H=38;5;110:*.tcc=38;5;110:*.cpp=38;5;81:*.hpp=38;5;110:*.m=38;5;110:*.cc=38;5;81:*.cs=38;5;81:*.cp=38;5;81:*.cxx=38;5;81:*.hxx=38;5;110:*.go=38;5;81:*.f=38;5;81:*.F=38;5;81:*.for=38;5;81:*.f90=38;5;81:*.F90=38;5;81:*.nim=38;5;81:*.rs=38;5;81:*.swift=38;5;219:*.scpt=38;5;219:*.hs=38;5;81:*.lhs=38;5;81:*.hi=38;5;110:*.zig=38;5;81:*.pyc=38;5;240:*.css=38;5;125;1:*.sass=38;5;125;1:*.scss=38;5;125;1:*.htm=38;5;125;1:*.html=38;5;125;1:*.eml=38;5;125;1:*.coffee=38;5;074;1:*.java=38;5;074;1:*.js=38;5;074;1:*.jsx=38;5;074;1:*.jsp=38;5;074;1:*.php=38;5;81:*.am=38;5;242:*.in=38;5;242:*.hin=38;5;242:*.scan=38;5;242:*.old=38;5;242:*.out=38;5;242:*.diff=48;5;197;38;5;232:*.patch=48;5;197;38;5;232;1:*.tiff=38;5;97:*.tif=38;5;97:*.TIFF=38;5;97:*.gif=38;5;97:*.icns=38;5;97:*.ico=38;5;97:*.jpg=38;5;97:*.jpeg=38;5;97:*.JPG=38;5;97:*.JPEG=38;5;97:*.png=38;5;97:*.PNG=38;5;97:*.drw=38;5;99:*.ps=38;5;99:*.svg=38;5;99:*.avi=38;5;114:*.mp4=38;5;114:*.ogm=38;5;114:*.wmv=38;5;114:*.dat=38;5;137;1:*.opus=38;5;137;1:*.wma=38;5;137;1:*.fon=38;5;66:*.fnt=38;5;66:*.ttf=38;5;66:*.otf=38;5;66:*.woff=38;5;66:*.woff2=38;5;66:*.7z=38;5;40:*.a=38;5;40:*.cpio=38;5;40:*.gz=38;5;40:*.lz=38;5;40:*.lz=38;5;40:*.rar=38;5;40:*.tar=38;5;40:*.tgz=38;5;40:*.xz=38;5;40:*.z=38;5;40:*.zip=38;5;40:*.deb=38;5;215:*.rpm=38;5;215:*.jar=38;5;215:*.apk=38;5;215:*.iso=38;5;124:*.bin=38;5;124:*.db=38;5;60:*.sqlite=38;5;60:*.o=38;5;241:*.swp=38;5;244:*.swo=38;5;244:*.tmp=38;5;244:*.err=38;5;160;1:*.error=38;5;160;1:*.stderr=38;5;160;1:*.swap=38;5;45:*.device=38;5;45:*.mount=38;5;45:*.automount=38;5;45:*.snapshot=38;5;45:*.path=38;5;45:*.torrent=38;5;116:*.gbr=38;5;7:*.scm=38;5;7:*.xcf=38;5;7:*.Rproj=38;5;11:*.jl=38;5;35:*.log=38;5;190:*.txt=38;5;253:'
export LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose true

# Some default completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
