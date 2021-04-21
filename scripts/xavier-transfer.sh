#! /usr/bin/bash

# Needed to run the following install command for inotifywait.
# sudo apt install inotify-tools

ORIGIN_FOLDER="/home/therring/Workspace"
DESTINATION_FOLDER="therring@192.168.1.2:/home/therring/Workspace"

while inotifywait -r -e modify,create,delete $ORIGIN_FOLDER
do
rsync -az $ORIGIN_FOLDER/ $DESTINATION_FOLDER
done
