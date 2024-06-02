# Change Directory Choice
cdc(){
  cd $(ls -d */ | fzf)
}
gdmf()
{
  git diff origin/main -- $(git diff main --name-only | fzf)
}

