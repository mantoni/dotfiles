function gA
  if count $argv > /dev/null
    git add -A $argv
  else
    git add -A .
  end
end
