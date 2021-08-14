function fish_prompt
  set exit_code $status
  if [ $USER = "root" ]
    set_color white
    set_color -b red
    echo -n "root"
    set_color normal
  end
  set branchname (git symbolic-ref --quiet --short HEAD 2> /dev/null)
  set dirname (prompt_pwd)

  if [ $TMUX ]
    tmux rename-window -t$TMUX_PANE "$dirname"
    set -e dirname
  end
  if [ "$branchname" = "master" -o "$branchname" = "main" ]
    set color_branch magenta
  else if [ "$branchname" ]
    set color_branch green
  end
  if [ "$dirname" -a "$branchname" ]
    set_color yellow
    echo -n "$dirname "
    set_color $color_branch
    echo -n $branchname
  else if [ "$branchname" ]
    set_color $color_branch
    echo -n $branchname
  else if [ "$dirname" ]
    set_color yellow
    echo -n $dirname
  end
  if [ $exit_code = 0 ]
    set_color normal
  else
    set_color red
  end
  echo -n '❯ '
  set_color normal
end
