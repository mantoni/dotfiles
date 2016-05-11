function npmcp
  set -l npm_prefix (npm config get prefix)
  set -l source "$npm_prefix/lib/node_modules/$1"
  if [ ! -e $source ]
    echo "$source not found"
    return 1
  end
  set -l target "node_modules/$1"
  rm -rf $target
  mkdir -p $target
  set -l files (ls $source | grep -v node_modules)
  for file in $files
    cp -r $source/$file $target/$file
  end
end
