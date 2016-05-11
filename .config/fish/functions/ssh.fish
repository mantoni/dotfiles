function ssh
  printf "\033k$argv\033\\"
  ssh $argv
end
