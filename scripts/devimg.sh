#!/bin/bash

devimg () {

if [[ -z "${BUILDER_PATH}" ]]; then
  # Print not found.
  echo "Builder dir not found!"
fi

# Start docker image.
$BUILDER_PATH/gui-docker -it --rm th3rring/builder:$1 bash
}

__find_imgs () {

if [[ -z "${BUILDER_PATH}" ]]; then
  # Print not found.
  echo "Builder dir not found!"
fi

# Helper function to remove trailing slashes.
__remove_slash () {
  echo ${@%/}
}

# Get filenames of images.
imgs="$(__remove_slash $(ls ${BUILDER_PATH} -F | grep \/$))"

# Generate list of completions.
COMPREPLY=($(compgen -W "$imgs" -- "${COMP_WORDS[1]}"))
}

complete -F __find_imgs devimg
