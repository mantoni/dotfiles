function merged
  set -l branch $argv[1]

  if [ "$branch" != 'main' -a "$branch" != 'master' ]
    echo -n "Require branch argument "
    set_color red
    echo -n "main"
    set_color normal
    echo -n " or "
    set_color red
    echo -n "master"
    set_color normal
    echo
    return 1
  end

  set -l pr_branch (git branch --show-current)
  if [ $pr_branch = $branch ]
    echo -n "Current branch is "
    set_color red
    echo -n $branch
    set_color normal
    echo
    return 1
  end

  git checkout $branch
  git pull
  git branch -D $pr_branch
end
