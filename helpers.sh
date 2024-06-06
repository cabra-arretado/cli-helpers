# Change Directory Choice
#

# Change Directory Choice
# Description: This function will prompt the user to select a choice between the directories in the current directory. Once selected the user will cd into the selected directory.
# Arguments: None.
# Usage: cdc
-cdc(){
  # `ls -d */` gonna list all the subdirectories in the current directory
  # `2> /dev/null` gonna redirect the error message to /dev/null suppresing it to be printed
  dir_list=$(ls -d */ 2> /dev/null)

  # `-z` check if the variable is empty, in this case we print the error message and return 1 (error code)
  if [ -z "$dir_list" ]; then
    echo "cdc: No psubdirectories found in the current directory."
    return 1
  fi

  # Pipe the list to fzf. Once selected in fzf we store the selected directory in the variable `selected_dir`
  selected_dir=$("$dir_list" | fzf)
  # `-z` check if the variable is empty, in this case we print the error message and return 1 (error code)
  if [ -z "$dir_list" ]; then
    echo "cdc: No directory selected"
    return 1
  fi
  # if everything is okay we just cd into the selected directory
  cd $dir_list
}

# Git Diff Main File
# Description: This function will show a list of the files changed on Git since the last main branch commit. After selecting a file, it will show the diff of the file.
# No parameters
-gdmf()
{
  git fetch --prune
  git diff origin/main -- $(git diff origin/main --name-only | fzf)
}

-gcore()
{
  git fetch --prune
  branche=$(git branch -r |\
    sed 's/origin\///' |\
    sed 's/^[[:space:]]*//' |\
    fzf)
  git checkout $branche
}
