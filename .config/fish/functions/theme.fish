function theme
  if [ (dark-mode status) = "off" ]
    set -x ITERM_PROFILE "Light"
  else
    set -x ITERM_PROFILE "Dark"
  end
  echo -e "\033]50;SetProfile=$ITERM_PROFILE\a"
end
