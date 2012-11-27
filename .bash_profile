export CLICOLOR=1

alias l='ls -lh --color'
alias ll='ls -alh --color'

if [ -e ~/.extras ]; then
  source ~/.extras
fi
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi

