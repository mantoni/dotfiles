export CLICOLOR=1

alias l='ls -lh'
alias ll='ls -alh'
alias v='vim'

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
