function changes
  set -l package_version (node -p "require('./package.json').version")
  git log v$package_version..HEAD --format="- %s (%an)" --reverse | sed -e 's/ (Maximilian Antoni)//g'
end
