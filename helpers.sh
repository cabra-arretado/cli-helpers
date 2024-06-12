#!/bin/bash

# --------- Change Directory Choice ---------
# WHEN I USE: When I want to change to a subdirectory that I don't remember the name
# DESCRIPTION: This function will prompt the user to select a choice between the subdirectories in the current directory. Once selected the user will cd into the selected directory.
# ARGUMENTS: None.
# USAGE: cdc
cdc(){
  # `ls -d */` gonna list all the subdirectories in the current directory
  dir_list=$(ls -d */)

  # `-z` check if the variable is empty, in this case we print the error message and return 1 (error code)
  if [ -z "$dir_list" ]; then
    echo "cdc: No subdirectories found in the current directory."
    return 1
  fi

  # Pipe the echoed list to fzf. Once selected in fzf we store the selected directory in the variable `selected_dir`
  selected_dir=$(echo "$dir_list" | fzf)
  # `-z` check if the variable is empty, in this case we print the error message and return 1 (error code)
  if [ -z "$selected_dir" ]; then
    echo "cdc: No directory selected"
    return 1
  fi
  # if everything is okay we just cd into the selected directory
  cd "$selected_dir"
}

# ------ Git Diff Main Files ------
# WHEN I USE: When I want to see the changes in the files since the last main branch commit
# Description: This function will show a list of the files changed on Git since the last main branch commit. After selecting a file, it will show the diff of the file.
# No parameters
gdmf()
{
  git fetch --prune
  git diff origin/main -- $(git diff origin/main --name-only | fzf)
}

gcore()
{
  git fetch --prune
  branche=$(git branch -r |\
    sed 's/origin\///' |\
    sed 's/^[[:space:]]*//' |\
    fzf)
  git checkout $branche
}
