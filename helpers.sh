# Change Directory Choice
cdc(){
  cd $(ls -d */ | fzf)
}
