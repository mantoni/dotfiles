#!/bin/bash
#
# Grabed from https://github.com/mathiasbynens/dotfiles
#
cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
  rsync --exclude ".git/" \
    --exclude=".gitmodules" \
    --exclude ".DS_Store" \
    --exclude "README.md" \
    --exclude "Brewfile" \
    --exclude "bootstrap.sh" \
    --exclude "screenshot.png" \
    --exclude "xterm-256color.terminfo" \
    -av . ~
}

if [ "$1" == "--update" ]; then
  git pull
  git submodule init
  git submodule update --recursive --remote
  exit 0
fi

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt

if [ -e ~/.bootstrap-extras.sh ]; then
  ~/.bootstrap-extras.sh
fi
