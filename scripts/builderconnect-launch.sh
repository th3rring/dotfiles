#!/bin/bash -u

docker run \
    -it \
    -p 10000:10000 \
    --user $(id -u):$(id -g) \
    -v $KL_BUILD_WORKSPACE_PATH:/Workspace \
    th3rring/builder:dart-xpra bash 
