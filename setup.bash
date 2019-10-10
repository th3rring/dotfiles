#!/bin/bash
# Make this variable local to this file so it's not an env var
install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

KRL_MACHINE='megamedes'
alias devssh='sshpass -p "Qrioqrio9" ssh -o StrictHostKeyChecking=no therring@'$KRL_MACHINE'.cs.rice.edu -Y'

alias dmux=$install_path'/dev-tmux.sh'

work_path='Workspace/xe2ez'
alias devcd='cd ~/'$work_path

# For the Rice VPN
# TODO: Didn't seem to work
echo "hi"
if [ -d "/opt/cisco/anyconnect" ]
then
	alias vpn=/opt/cisco/anyconnect/bin/vpn
	echo "Aliased VPN"
fi

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

alias devupdate='git -C '$install_path' pull'
