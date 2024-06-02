# Change Directory Choice
cdc(){
  cd $(ls -d */ | fzf)
}

# Git Diff Main File
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
