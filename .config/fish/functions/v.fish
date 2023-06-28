function v
  if count $argv > /dev/null
    vim $argv
  else if [ -e Session.vim ]
    vim -S Session.vim
  else
    vim
  end
end
