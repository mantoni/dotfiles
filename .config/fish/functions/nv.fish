function nv
  if count $argv > /dev/null
    if [ -e /opt/homebrew ]
      set -g fish_user_paths "/opt/homebrew/opt/node@$argv/bin" $fish_user_paths
    else
      set -g fish_user_paths "/usr/local/opt/node@$argv/bin" $fish_user_paths
    end
  else
    node --version
  end
end
