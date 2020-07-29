#!/bin/bash

devcd () {

if [[ -z "${WORKSPACE_PATH}" ]]; then
  # Print not found.
  echo "Workspace dir not found!"
fi

cd "$WORKSPACE_PATH/$1" 
}

# _ls () {

# if [[ -z "${WORKSPACE_PATH}" ]]; then
#   # Print not found.
#   echo "Workspace dir not found!"
# fi

# ls $WORKSPACE_PATH

# }

complete -W "$(ls $WORKSPACE_PATH)" devcd
# complete -F _ls devcd
