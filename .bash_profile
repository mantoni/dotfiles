export CLICOLOR=1

alias l='ls -lh'
alias ll='ls -alh'
alias gA='git add -A .'
alias gci='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gs='git status'
alias gre='git rebase'

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
      RESULTS=$(f "$1*")
      COUNT=`echo $RESULTS | wc -w`
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

if [ -e ~/.extras ]; then
  source ~/.extras
fi
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi
