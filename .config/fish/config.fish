# non-interactive users (ssh, sync)
if not status --is-interactive
  exit # skips the rest of this file; does not actually exit the shell!
end

set -gx TERM 'xterm-256color'
set -gx CLICOLOR 1
set -gx EDITOR vim

. ~/.config/fish/base16-material.dark.fish

set -gx fish_greeting
set -gx fish_color_autosuggestion 707880
set -gx fish_color_command purple
set -gx fish_color_param cyan
set -gx fish_color_selection --background=263238
set -gx fish_color_search_match --background=263238
set -g fish_user_paths "/usr/local/bin" "/usr/local/opt/node@8/bin" $fish_user_paths

alias l 'ls -lh'
alias ll 'ls -alh'
alias gd 'git diff --color-moved'
alias gdw 'git diff --color-moved -w'
alias gdc 'git diff --color-moved --cached'
alias gl 'git log --graph --decorate --date=relative'
alias glo 'git log --graph --decorate --date=relative --oneline'
alias gbr 'git for-each-ref --sort=-committerdate refs/heads/ --format=\'%(HEAD) %(color:green)%(refname:short)%(color:reset) - %(color:yellow)%(objectname:short)%(color:reset) - %(color:white)%(authorname)%(color:reset) (%(committerdate:relative))\''
alias gs 'git status'
alias gre 'git rebase'
alias gri 'git rebase -i --autostash'
alias gt 'git tag'
alias gp 'git pull'
alias ni 'npm install'
alias nu 'npm update'
alias ns 'npm start'
alias nt 'npm test'
alias nw 'npm run watch'
alias t 'tmux attach -t dev; or tmux new-session -s dev'
alias grep 'grep --color=auto'

if [ -e ~/.secrets ]
  . ~/.secrets
end
