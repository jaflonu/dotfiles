#!/bin/zsh

# Cleaning up the terminal after usage.

# Clear console
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
