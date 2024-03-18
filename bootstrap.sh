#!/usr/bin/env bash

function installPackages() {
  # Install Homebrew.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Make sure we’re using the latest Homebrew.
  brew update

  # Upgrade any already-installed formulae.
  brew upgrade

  # Install powerlevel10k
  brew install powerlevel10k

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

  # Install docker
  brew install docker docker-compose

  # Install colima
  brew install colima

  # Install nodejs
  brew install nodejs@18

  # Install yarn -- must be installed after nodejs
  brew install yarn

  # Install go
  brew install go

  # Install fonts for 'Hack Nerd Front Mono'
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font

  # Install ripgrep
  brew install ripgrep

  # Install lazygit
  brew install lazygit

  # Install gnu sed
  brew install gnu-sed

  # Install KeePassXC
  brew install --cask keepassxc
}

function doIt() {
  # Create config directories
  mkdir -p ~/.config/alacritty
  mkdir -p ~/.config/tmux
  mkdir -p ~/.docker

  installPackages;

  # Configure git
  git config --global user.name "Jiyeol Lee"
  git config --global user.email "ka.felix496@gmail.com"

  # Create symbolic links
  ln -s ~/dotfiles/.tmux.conf ~/.config/tmux/tmux.conf
  ln -s ~/dotfiles/.shorten_current_path.sh ~/.config/tmux/.__shorten_current_path.sh
  ln -s ~/dotfiles/.alacritty.toml ~/.config/alacritty/alacritty.toml
  ln -s ~/dotfiles/.nvim ~/.config/nvim
  ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh
  ln -s ~/dotfiles/.aliases ~/.aliases
  ln -s ~/dotfiles/.exports ~/.exports
  ln -s ~/dotfiles/.profile ~/.zshrc

  # Configure docker
  echo -e "{\n\t\"cliPluginsExtraDirs\": [\n\t\t\"/opt/homebrew/lib/docker/cli-plugins\"\n\t],\n\t\"currentContext\": \"colima\"\n}" > ~/.docker/config.json
  
  source ~/.zshrc
}

doIt;

echo "Configurations are done!";
echo "Do not forget to run ':Copilot setup' in neovim!";
echo "Do not forget to run 'Prefix + I' in tmux!";

unset installPackages;
unset doIt;
