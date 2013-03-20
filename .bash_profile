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

function f {
  if [[ $# > 0 ]]; then
    find . -type d \( -path '**/node_modules' -o -path '**/.git' \) -prune -o -name $1 -print
  fi
}

function v {
  if [[ $# > 0 ]]; then
    if [[ $1 == "*"* ]]; then
      RESULTS=$(f "$1*")
      for RESULT in $RESULTS
      do
        IFS='/' read -ra PARTS <<< "$RESULT"
        PROJECT_DIR=${PARTS[1]}
        if [ -e $PROJECT_DIR/.git ]; then
          cd $PROJECT_DIR
          vim $(f "$1*")
          return
        fi
      done
      vim $RESULTS
    else
      vim $1
    fi
  else
    vim
  fi
}
