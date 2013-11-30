send-keys 'node_modules/.bin/mocha --watch' Enter
split-window -h -l 120
send-keys 'vim' Enter ',n' Enter
select-pane -L
split-window -l 10
send-keys 'node_modules/.bin/autolint' Enter
select-pane -R
