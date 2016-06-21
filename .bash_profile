export TERM='xterm-256color'
export CLICOLOR=1
export EDITOR=vim
export HISTCONTROL=ignoreboth:erasedups

. ~/.base16-material.dark.sh

alias l='ls -lh'
alias ll='ls -alh'
alias gd='git diff'
alias gdw='git diff -w'
alias gdc='git diff --cached'
alias gl='git log --graph --decorate --date=relative --format="%C(yellow)%h%C(reset) %C(green)(%ar)%C(reset) %C(white)%s%C(reset) %C(blue)- %an%C(reset)%C(yellow)%d%C(reset)"'
alias gs='git status'
alias gre='git rebase'
alias gt='git tag'
alias gp='git pull'
alias t='tmux attach -t dev || tmux new-session -s dev'
alias grep='grep --color'

function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status --short --branch
  fi
}

function ga {
  if [[ $# > 0 ]]; then
    git add "$@"
  else
    git add .
  fi
}

function gA {
  if [[ $# > 0 ]]; then
    git add -A "$@"
  else
    git add -A .
  fi
}

function gci {
  git commit "$@"
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

function npmcp {
  NPM_PREFIX=`npm config get prefix`
  SOURCE="$NPM_PREFIX/lib/node_modules/$1"
  if [ ! -e $SOURCE ]; then
    echo "$SOURCE not found"
    return 1
  fi
  TARGET="node_modules/$1"
  rm -rf $TARGET
  mkdir -p $TARGET
  FILES=`ls $SOURCE | grep -v node_modules`
  for FILE in $FILES; do
    cp -r $SOURCE/$FILE $TARGET/$FILE
  done
}

settitle() {
  tmux rename-window -t$TMUX_PANE "$dirname"
}

function ssh() {
  settitle "$*"
  command ssh "$@"
}

function render_prompt() {
  if [ "$USER" == "root" ]; then
    echo -ne "\033[41mroot\033[0m"
  fi
  local BRANCHNAME=`git symbolic-ref --short HEAD 2>/dev/null`

  if [ "$PWD" = $HOME ]; then
    local DIRNAME="~"
  else
    local DIRNAME=${PWD##*/}
  fi
  if [ $TMUX ]; then
    settitle $DIRNAME
    DIRNAME=
  else
    local DIRNAME="\033[33m$DIRNAME\033[0m"
  fi
  if [ "$BRANCHNAME" == "master" ]; then
    local BRANCHNAME="\033[35m$BRANCHNAME\033[0m"
  elif [ $BRANCHNAME ]; then
    local BRANCHNAME="\033[32m$BRANCHNAME\033[0m"
  fi
  if [[ $DIRNAME && $BRANCHNAME ]]; then
    echo -ne "[$DIRNAME $BRANCHNAME]"
  elif [ $BRANCHNAME ]; then
    echo -ne "[$BRANCHNAME]"
  elif [ $DIRNAME ]; then
    echo -ne "[$DIRNAME]"
  fi
  if [ "$USER" == "root" ]; then
    echo -ne "# "
  else
    echo -ne "$ "
  fi
}
PS1="\$(render_prompt)"

if [ -e ~/.secrets ]; then
  source ~/.secrets
fi
