function vs
  if [ -e Session.vim ]
    if count $argv > /dev/null
      vim -S Session.vim $argv
    else
      vim -S Session.vim
    end
  else
    if count $argv > /dev/null
      vim $argv
    else
      vim
    end
  end
end
