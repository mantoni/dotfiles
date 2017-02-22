function nv
  if count $argv > /dev/null
    set -g fish_user_paths "/usr/local/opt/node@$argv/bin" $fish_user_paths
  else
    node --version
  end
end
