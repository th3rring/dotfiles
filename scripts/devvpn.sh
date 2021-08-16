#!/bin/bash
# Thomas Herring 2021

VPN_CONFIG='dallas'

# Function to print different command options.
__options() {
  echo "connect disconnect status rice"
}

# Generate completion options.
__generate_options() {
  local options=$(__options)

  # Generate list of completions.
  COMPREPLY=($(compgen -W "$options" -- "${COMP_WORDS[1]}"))
}

# Choose a command based on user input.
devvpn() {

  # Matching first character of option to choose that function.
  case $1 in
    [Cc]* ) __connect; ;;
    [Dd]* ) __disconnect; ;;
    [Ss]* ) __status; ;;
    [Rr]* ) __rice; ;;
    * ) echo "Invalid command. Choose from: $(__options)";;
  esac
}

# Start VPN.
__connect() {
  sudo openvpn3 session-start --config $VPN_CONFIG

  # Removes output
  # openvpn3 session-start --config pop_os_la.ovpn </dev/null &>/dev/null & 
}

# Disconnect from VPN.
__disconnect() {
  sudo openvpn3 session-manage --disconnect --config $VPN_CONFIG
}

# Print status of VPN.
__status() {
  sudo openvpn3 sessions-list
}

# Connect to Rice VPN client.
__rice() {
	/opt/cisco/anyconnect/bin/vpn
}

complete -F __generate_options devvpn
