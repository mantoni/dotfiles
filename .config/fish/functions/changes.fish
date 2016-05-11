function changes
  set -l version (node -p "require('./package.json').version")
  git log v$version..HEAD --format="- %s (%an)" --reverse | sed -e 's/ (Maximilian Antoni)//g'
end
