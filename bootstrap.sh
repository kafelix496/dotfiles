#!/usr/bin/env bash

function installPackages() {
  # Install command-line tools using Homebrew.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  # Install alacritty
  brew install --cask --no-quarantine alacritty
  /Users/jiyeol-lee/dotfiles/

  # Install tmux
  # ref1: https://github.com/tmux/tmux/wiki/Installing
  # ref2: https://github.com/tmux-plugins/tpm
  brew install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/tpm/

  # Install neovim
  # ref: https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package
  brew install neovim

  # Install nodejs
  brew install nodejs

  # Install fonts for 'Hack Nerd Front Mono'
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  # Install ripgrep
  brew install ripgrep

  # Install lazygit
  brew install lazygit
}

function doIt() {
  mkdir -p ~/.config/alacritty
  mkdir -p ~/.config/tmux

  installPackages;

  ln -s ~/dotfiles/.tmux.conf ~/.config/tmux/tmux.conf
  ln -s ~/dotfiles/.alacritty.toml ~/.config/alacritty/alacritty.toml
  ln -s ~/dotfiles/.nvim ~/.config/nvim
  ln -s ~/dotfiles/.aliases ~/.aliases
  ln -s ~/dotfiles/.exports ~/.exports
  ln -s ~/dotfiles/.profile ~/.zshrc
  
  source ~/.zshrc
}

doIt;

echo "Configurations are done!";
echo "Do not forget to run ':Copilot setup' in neovim!";
echo "Do not forget to run 'Prefix + I' in tmux!";

unset installPackages;
unset doIt;
