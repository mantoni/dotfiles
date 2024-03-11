function g
  if count $argv > /dev/null
    if test "$argv[1]" = 'checkout' || test "$argv[1]" = 'co'
      if begin test "$argv[2]" = '.'; or test "$argv[2]" = '--' && test "$argv[3]" = '.'; end
        read -l -P 'Discard all changes? [y/N] ' confirm
        if test $confirm = '' || test $confirm = 'n' || test $confirm = 'N'
          return 1
        end
      end
    end
    git $argv
  else
    git status --short --branch
  end
end
