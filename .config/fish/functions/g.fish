function g
  if count $argv > /dev/null
    git $argv
  else
    git status --short --branch
  end
end
