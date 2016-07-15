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

alias l 'ls -lh'
alias ll 'ls -alh'
alias gd 'git diff'
alias gdw 'git diff -w'
alias gdc 'git diff --cached'
alias gl 'git log --graph --decorate --date=relative'
alias gs 'git status'
alias gre 'git rebase'
alias gt 'git tag'
alias gp 'git pull'
alias t 'tmux attach -t dev; or tmux new-session -s dev'
alias grep 'grep --color=auto'

if [ -e ~/.secrets ]
  . ~/.secrets
end
