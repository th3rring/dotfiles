#!/bin/bash
install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

krl_machine='megamedes'
alias devssh='sshpass -p "Qrioqrio9" ssh -o StrictHostKeyChecking=no therring@'$krl_machine'.cs.rice.edu'

alias dmux=$install_path'/dev-tmux.sh'

work_path='Workspace/xe2ez'
alias devcd='cd ~/'$work_path

# For the Rice VPN
if [ -d "/opt/cisco/anyconnect/bin/vpn" ]
then
	alias vpn=/opt/cisco/anyconnect/bin/vpn
fi
