# https://github.com/yoshuawuyts/dotfiles/blob/master/bin/dev
function dev
  if count $argv > /dev/null
    open "https://devdocs.io/#q=$argv"
  else
    open 'https://devdocs.io'
  end
end
