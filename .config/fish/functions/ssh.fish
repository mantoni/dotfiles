function ssh
  printf "\033k$argv\033\\"
  command ssh $argv
end
