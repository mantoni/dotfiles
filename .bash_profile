export CLICOLOR=1

alias l='ls -lh'
alias ll='ls -alh'

if [ -e ~/.extras ]; then
  source ~/.extras
fi
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status --short --branch
  fi
}

F_CMD='find . -type d \( -path "**/node_modules" -o -path "**/.*" -o -path "**/public" \) -prune -o -wholename "$1"'
function f {
  if [[ $# > 1 ]]; then
    eval "$F_CMD -exec grep -nHF \"$2\" {} \; ;"
  elif [[ $# > 0 ]]; then
    eval "$F_CMD -print"
  fi
}

function v {
  if [[ $# > 0 ]]; then
    if [[ $1 == "*"* ]]; then
      RESULTS=$(f "$1*")
      COUNT=`echo $RESULTS | wc -w`
      if [[ $COUNT > 5 ]]; then
        read -p "Found $COUNT results. Open all? (y/n) " -n 1
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
