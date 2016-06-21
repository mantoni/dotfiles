function fish_prompt
  if [ $USER = "root" ]
    set_color white
    set_color -b red
    echo -n "root"
    set_color normal
  end
  set branchname (git symbolic-ref -q --short HEAD ^ /dev/null)
  set dirname (prompt_pwd)

  if [ $TMUX ]
    tmux rename-window -t$TMUX_PANE "$dirname"
    set -e dirname
  end
  if [ "$branchname" = "master" ]
    set color_branch magenta
  else if [ "$branchname" ]
    set color_branch green
  end
  if [ "$dirname" -a "$branchname" ]
    echo -n '['
    set_color yellow
    echo -n "$dirname "
    set_color $color_branch
    echo -n $branchname
    set_color normal
    echo -n ']'
  else if [ "$branchname" ]
    echo -n '['
    set_color $color_branch
    echo -n $branchname
    set_color normal
    echo -n ']'
  else if [ "$dirname" ]
    echo -n '['
    set_color yellow
    echo -n $dirname
    set_color normal
    echo -n ']'
  end
  if [ $USER = "root" ]
    echo -n '# '
  else
    echo -n '$ '
  end
end
