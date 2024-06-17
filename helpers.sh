#!/bin/bash

# --------- Constants ---------
# This variables will change the default behavior of the functions

# This will be the command that will be used to view the diff of the file
export DIFF_VIEWER="nvim -R"

# --------- Change Directory Choice ---------
# WHEN I USE: When I want to change to a subdirectory that I don't remember the name
# DEPENDENCIES: fzf, ls
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

# ------ Git Diff Main File ------
# WHEN I USE: When I want to see the changes in the ONE specific file since the last main branch commit
# DESCRIPTION: This function will show a list of the files changed on Git since the last main branch commit. After selecting a file, it will show the diff of the file.
# DEPENDENCIES: fzf, git
# PARAMETERS: No parameters
# USAGE: gdmf
gdmf()
{
  # Fetch the last changes from the remore repository, and prune branches that no longer exist
  git fetch --prune
  changed_files=$(git diff origin/main --name-only)

  # Check if there are no files changed since the last main branch commit
  if [ -z "$changed_files" ]; then
    echo "No files changed since the last main branch commit"
    return 0
  fi

  # Show the list of files changed since the last main branch commit
  file_to_diff=$(echo "$changed_files" | fzf)

  # If not file is selected, return 1
  if [ -z "$file_to_diff" ]; then
    echo "No file selected"
    return 1
  fi

  # Show the diff of the selected file
  if [ -z "$DIFF_VIEWER" ]; then
    # If the DIFF_VIEWER is not set, we just use the default git diff
    git diff origin/main -- "$file_to_diff"
    return 0
  else
    # If the DIFF_VIEWER is set, we use it to show the diff.
    # We use eval to execute the command stored in the variable
    git diff origin/main -- "$file_to_diff" | eval $DIFF_VIEWER
    return 0
  fi
}

# ------ Git CheckOut REMOte ------
# WHEN I USE: When I want to checkout a remote branch that I don't remeber the exact name
# DESCRIPTION: This function will show a list of the remote branches and checkout the selected branch
# DEPENDENCIES: fzf, git, sed
# PARAMETERS: No parameters
# USAGE: gcoremo
gcoremo()
{
  # Fetch the last changes from the remore repository, and prune branches that no longer exist
  git fetch --prune

  # declared list of remote branches and store the selected branch in the variable
  branches=$(git branch -r)

  # If no branches are found, return 1
  if [ -z "$branches" ]; then
    echo "No remote branches found"
    return 1
  fi

  # let's remove the "HEAD -> " prefix from the branches using sed
  branches=$(echo "$branches" | sed 's/origin\/HEAD -> origin\/main//g')
  #TODO: to use wildcard for anything ater the origin/HEAD

  # remove the leading spaces from the branches using sed
  branches=$(echo "$branches" | sed '/^[[:space:]]*$/d')

  # remove the "origin/" prefix from the branches using sed
  branches=$(echo "$branches" | sed 's/origin\///')


  # remove the leading spaces from the branches using sed
  branches=$(echo "$branches" | sed 's/^[[:space:]]*//')

  # Select the branch using fzf
  selected_branch=$(echo "$branches" | fzf)


  # If no branch is selected, return 1
  if [ -z "$selected_branch" ]; then
    echo "No branch selected"
    return 1
  fi

  # Checkout the selected branch
  git checkout "$branche"
}
