function v
  if [ -e .git ]
    if count $argv > /dev/null
      vim +Obsession +"e $argv[1]"
    else
      vim +Obsession
    end
  else
    if count $argv > /dev/null
      vim $argv
    else
      vim
    end
  end
end
