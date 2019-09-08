#!/bin/bash
install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

krl_machine='megamedes'
alias devssh='sshpass -p "Qrioqrio9" ssh -o ScriptHostKeyChecking=no teh6@'$krl_machine'.cs.rice.edu'

alias dmux=$install_path'/dev-tmux.sh'

work_path='Workspace/xe2ez'
alias devcd='cd ~/'$work_path