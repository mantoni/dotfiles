function v
  if count $argv > /dev/null
    vim $argv
  else
    vim
  end
end
