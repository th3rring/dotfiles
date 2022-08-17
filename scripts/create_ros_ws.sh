#!/bin/bash

create-ros-ws() {

  ws_name="ros_ws"

  if [ ! $# -eq 0 ]; then
    ws_name=$1
  fi

  ros_ws_url="git@github.com:th3rring/ros_ws.git"

  git clone $ros_ws_url $1
  mkdir -p $ws_name/src

}
