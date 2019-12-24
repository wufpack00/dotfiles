#! /bin/zsh

# executed whenever the current working directory is changed
function chpwd() {
  print -Pn "\e]2;%n@%M: %~\a"
  ll
}
