# Max' dotfiles

Blindly following [the GitHub orders](http://dotfiles.github.com).

## Installation

Nicked that [bootstrap](https://github.com/mathiasbynens/dotfiles) script.

```bash
source bootstrap.sh
```

## Additional setup

### Syntastic

JSLint support:

```
$ npm install jslint -g
```

JSONLint support:

```
$ npm install jsonlint -g
```

## Secrets

I keep my environment specific stuff in `.extras` and `.secrets`.

```bash
export GIT_AUTHOR_NAME='Dude'
export GIT_AUTHOR_EMAIL='dude@domain.com'
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
```

