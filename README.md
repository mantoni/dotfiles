# Max' dotfiles

## Homebrew

```bash
brew install git
brew install neovim
brew install node
brew install lsd
brew install tmux
brew install fish
brew install fzf
brew install fd
brew install ripgrep
brew install bat
brew install fisher
fisher install PatrickF1/fzf.fish
```

**Making fish the default shell:**

```bash
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s `which fish`
```

**Global npm modules:**

```bash
npm i -g eslint_d
npm i -g json
npm i -g diff-so-fancy
npm i -g dark-mode-cli
```

**Dotfiles:**

```bash
./bootstrap.sh --update # Update all submodules
./bootstrap.sh # Install
```

