export TERM='xterm-256color'
export CLICOLOR=1
export EDITOR=vim

. ~/.base16-default.dark.sh

alias l='ls -lh'
alias ll='ls -alh'
alias gA='git add -A .'
alias gci='git commit'
alias gd='git diff'
alias gdw='git diff -w'
alias gdc='git diff --cached'
alias gl='git log --graph --decorate --date=relative --format="%C(yellow)%h%C(reset) %C(green)(%ar)%C(reset) %C(white)%s%C(reset) %C(blue)- %an%C(reset)%C(yellow)%d%C(reset)"'
alias gs='git status'
alias gre='git rebase'
alias gt='git tag'
alias t='tmux attach -t dev || tmux new-session -s dev'

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status --short --branch
  fi
}

function ga {
  if [[ $# > 0 ]]; then
    git add $@
  else
    git add .
  fi
}

F_CMD='find . -type d \( -path "**/node_modules" -o -path "**/.*" -o -path "**/public" \) -prune -o -wholename "$1"'
function f {
  if [[ $# > 1 ]]; then
    eval "$F_CMD -exec grep -nHF \"$2\" {} \; ;"
  elif [[ $# > 0 ]]; then
    eval "$F_CMD -print"
  else
    echo 'Usage: f file_name [file_content]'
  fi
}

function v {
  if [[ $# > 0 ]]; then
    if [[ $1 == "*"* ]]; then
      local RESULTS=$(f "$1*")
      local COUNT=`echo $RESULTS | wc -w`
      if [[ $COUNT > 5 ]]; then
        read -p "Found $COUNT results. Open all? (Y/n) " -n 1
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
          return
        fi
      fi
      vim $RESULTS
    else
      vim $1
    fi
  else
    vim
  fi
}

function changes {
  local VERSION=$(node -p "require('./package.json').version")
  git log v$VERSION..HEAD --format="- %s (%an)" --reverse | sed -e 's/ (Maximilian Antoni)//g'
}

function parse_git_branch() {
  local NAME=`git symbolic-ref --short HEAD 2>/dev/null`
  if [ "$NAME" == "master" ]; then
    echo -ne "\033[35m$NAME\033[0m"
  else
    echo -ne "\033[32m$NAME\033[0m"
  fi
}
function parse_user() {
  if [ "$USER" == "root" ]; then
    echo -ne "\033[41mroot\033[0m"
  fi
}
PS1="\$(parse_user)[\[\033[33m\]\W\[\033[0m\] \$(parse_git_branch)]$ "

if [ -e ~/.extras ]; then
  source ~/.extras
fi
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi
