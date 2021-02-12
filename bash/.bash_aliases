#
# ~/.bash_aliases
#

# Redefined commands
alias ls='ls -hN --color=auto --group-directories-first'
alias la='ls -a --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias mkd='mkdir -pv'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Utilities
alias p='sudo pacman'
alias cf='xclip -sel c <'
alias v='vim'
alias sv='sudo vim'
alias g='git'
alias x='pdflatex'

# Wake prototype
function wake() {
	case $1 in
		gatsby)
			printf "Gatsby has been woken.\n"
			;;
		conda)
			printf "Conda has been woken.\n"
			;;
		*)
			printf "Option not recognized.\n"
			;;
	esac
}
