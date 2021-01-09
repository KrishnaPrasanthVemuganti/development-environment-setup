#!/bin/bash

# Update and Upgrade
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade && sudo apt autoremove

# Updating Git
sudo add-apt-repository ppa:git-core/ppa && sudo apt update && sudo apt install git

# Set Git User Name and Email
git config --global user.name "Your name"
git config --global user.email "Your email"

# Create SSH Key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add Generated SSH Key
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
ssh-add -l

# Coping SSH Key to clip
clip.exe < ~/.ssh/id_ed25519.pub

# Testing SSH
ssh -T git@github.com

# Install ZSH
sudo apt install zsh

# Installing Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerline10k Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Powerline10k Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Python 3
sudo apt update && sudo apt install python3 python3-pip
sudo ln -s /usr/bin/python3 /usr/bin/python

# Python 2.7
#sudo apt update && sudo apt install python2.7
#sudo ln -s /usr/bin/python2.7 /usr/bin/python

#fnm and node
sudo apt install unzip
curl -fsSL https://fnm.vercel.app/install | bash
fnm --version
fnm ls-remote
echo -e "Please enter node version u want to install: "
read version
fnm install $version
# Node and NPM versions
node -v && npm -v

#Install Gatsby
sudo apt install build-essential libvips-dev libpng-dev
npm install -g gatsby-cli node-gyp

# Install dotnetcore sdk
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0

# Install dotnetcore runtime
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-5.0

