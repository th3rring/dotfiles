#!/bin/bash
# Thomas Herring 2021

# Make this variable local to this file so it's not an env var
install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

KRL_MACHINE='oceanus'

export VISUAL=lvim
export EDITOR="$VISUAL"


# For the Rice VPN
# if [ -d "/opt/cisco/anyconnect" ]
# then
# 	alias vpn=/opt/cisco/anyconnect/bin/vpn
# fi

# Copied from https://dchua.com/2014/07/15/x11-forwarding-over-remote-ssh-tmux/
# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISPLAY=`cat ~/.display.txt`
    fi
}

# This is run before every command.
preexec() {
    # Don't cause a preexec for PROMPT_COMMAND.
    # Beware!  This fails if PROMPT_COMMAND is a string containing more than one command.
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return

    update-x11-forwarding

    # Debugging.
    #echo DISPLAY = $DISPLAY, display.txt = `cat ~/.display.txt`, STY = $STY, TMUX = $TMUX
}
trap 'preexec' DEBUG

# Old command to auto ssh into a kl machine.
# alias kl-ssh='sshpass -p "*******" ssh -o StrictHostKeyChecking=no therring@'$KRL_MACHINE'.cs.rice.edu -Y'

# Command to build and install all suckless tools.
# alias devupdate='git -C '$install_path' pull && sudo bash '$install_path'/suckless/update.sh && bash '$install_path'/statusbar/link.sh'
alias devupdate='git -C '$install_path' pull'
alias devdot='cd '$install_path
alias devnvim='cd '$install_path/../lvim
alias devscripts='cd '$install_path/scripts
alias devbuilder='kl-builder'
alias downloads='cd ~/Downloads'

source $install_path/scripts/devcd.sh
source $install_path/scripts/devvpn.sh
source $install_path/scripts/create_ros_ws.sh

alias xopen='xdg-open'
alias lg='lazygit'
alias nvim='lvim'

# Add Cling to path
export PATH="$install_path/cling/bin:$PATH"

# Add go bin to path
export PATH="/home/therring/go/bin:$PATH"

# Add Lvim to path
export PATH="/home/therring/.local/bin/:$PATH"
