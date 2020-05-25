#!/bin/zsh

# The profile file, runs on login.
# Just some useful env-variables.

# Setting PATH to include private bin
[[ -d "$HOME/bin" ]] && PATH="$HOME/.local/bin"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"

# Default programs
export EDITOR="vim"
export BROWSER="firefox"
export STATUSBAR="i3blocks"
