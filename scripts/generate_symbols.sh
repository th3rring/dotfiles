#!/bin/bash
# Author: Thomas Herring

# Command for building compile commands.
catkin_command() {
  catkin build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
}

# Command to remove old compile commands.
remove_old_commands() {
  rm ./compile_commands.json 
}

# Check if we have catkin installed.
if command -v catkin &> /dev/null
then
  
  # If so, move to workspace directory and ask to rebuild.
  workspace_dir="$(catkin locate --workspace "$(pwd)")"
  cd $workspace_dir
  while true; do
      read -p "Would you like to rebuild the workspace? [Y/n]" yn
      case $yn in
        [Yy]* ) catkin_command; break;;
        "" ) catkin_command; break;;
          [Nn]* ) break;;
          * ) echo "Invalid input";;
      esac
  done
else

  # If not, assume we're in the workspace directory and do not rebuild.
  echo "Catkin not found on machine. Using working directory as workspace and not building..."
  workspace_dir="$(pwd)"
fi

concatenated=$workspace_dir"/compile_commands.json"

# Ask user if they want to delete the old compile_commands.json file.
if test -f $concatenated; then
  while true; do
      read -p "Delete old compile_commands.json? [Y/n]" yn
      case $yn in
        [Yy]* ) remove_old_commands; break;;
        "" ) remove_old_commands; break;;
          [Nn]* ) break;;
          * ) echo "Invalid input";;
      esac
  done
fi

echo "Making new compile_commands.json at top level workspace directory..."
touch $concatenated
echo "[" > $concatenated

# Combine all compile commands together.
# Found this code here https://github.com/catkin/catkin_tools/issues/551
first=1
for d in build/*/
do
    f="$d/compile_commands.json"

    if test -f "$f"; then
      
        # Make sure we prepend with a comma to keep json formatting.
        if [ $first -eq 0 ]; then
            echo "," >> $concatenated
        fi

        cat $f | sed '1d;$d' >> $concatenated
    fi

    first=0
done

echo "]" >> $concatenated

echo "***Done***"



