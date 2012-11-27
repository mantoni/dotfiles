export CLICOLOR=1

alias l='ls -lh'
alias ll='ls -alh'

if [ -e ~/.extras ]; then
  source ~/.extras
fi
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi

