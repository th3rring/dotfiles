#! /bin/bash

ORIGIN_FOLDER="/home/therring/Workspace"
DESTINATION_FOLDER="therring@192.168.1.2:/home/therring/Workspace"

while inotifywait -r -e modify,create,delete $ORIGIN_FOLDER
do
rsync -avz $ORIGIN_FOLDER/ $DESTINATION_FOLDER
done
