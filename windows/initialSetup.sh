#!/bin/bash

DisplayErrorAndExit () {
	echo "usage: ./initialSetup.sh \"Full Name\" youremail@email.com"
	exit 1
}

# Install DotNet Core Prerequisites
InstallDotNetCorePrerequisites () {
	wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb
	sudo apt-get update
	sudo apt-get install -y apt-transport-https
	sudo apt-get update
}

[[ -z "$1" ]] && { echo "Parameter 2 FullName is empty!"; DisplayErrorAndExit; }
[[ -z "$2" ]] && { echo "Parameter 3 Email is empty!"; DisplayErrorAndExit; }

# Update and Upgrade
echo "Updating and upgrading packages"
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade && sudo apt autoremove

# Updating Git
echo "Installing latest version of GIT"
sudo add-apt-repository ppa:git-core/ppa && sudo apt update && sudo apt install git

echo "Setting GIT config options"
# Set Git User Name and Email
git config --global user.name "$1"
git config --global user.email $2

#avoid git status showing all your files as modified because of the automatic EOL conversion done
git config --global core.autocrlf input

echo "Creating ssh key"
# Create SSH Key
ssh-keygen -t ed25519 -C $2

# Add Generated SSH Key
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
ssh-add -l

echo "Coping ssh key"
# Coping SSH Key to clip
clip.exe < ~/.ssh/id_ed25519.pub

read -p "After registering copied ssh key in github, Press enter to test yout key with github..."

# Testing SSH
ssh -T git@github.com

echo "Installing fzf - fuzzy finder"
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo -n "Enter a which python version you want to install(3/2/(n)one):"
read python

if [ $python == "3" ]
then
	sudo apt update
	sudo apt install python3 python3-pip
	sudo ln -s /usr/bin/python3 /usr/bin/python
elif [ $python == "2" ]
then
	sudo apt update
	sudo apt install python2.7
	sudo ln -s /usr/bin/python2.7 /usr/bin/python
fi

# fnm and node
sudo apt install unzip
curl -fsSL https://fnm.vercel.app/install | bash
export PATH=/home/ubuntu/.fnm:$PATH
eval "`fnm env`"
fnm --version
fnm ls-remote
echo -e "Please enter node version u want to install:"
read version
fnm install $version
# Node and NPM versions
node -v && npm -v

echo -n "Do you want to install gatsby-cli and node-gyp(Y/n):"
read gatsby
if [ $gatsby == "Y" ]
then
	# Install Gatsby
	sudo apt install build-essential libvips-dev libpng-dev
	npm install -g gatsby-cli node-gyp
fi

# Install dotnetcore sdk/runtime 
PS3='Please select which dotnet version you want to install:'
options=("ASPNETCORE Runtime 5.0" 
		".Net Runtime 5.0" 
		".Net SDK 5.0" 
		"Anything else continue without installing")
select opt in "${options[@]}"
do
    case $opt in
        "ASPNETCORE Runtime 5.0")
			InstallDotNetCorePrerequisites
			sudo apt-get install -y aspnetcore-runtime-5.0
            break
            ;;
        ".Net Runtime 5.0")
			InstallDotNetCorePrerequisites
			sudo apt-get install -y dotnet-runtime-5.0
            break
            ;;
	    ".Net SDK 5.0")
			InstallDotNetCorePrerequisites
			sudo apt-get install -y dotnet-sdk-5.0
	        break
	        ;;
        *) break
            ;;
    esac
done

echo -n "Do you want to installdocker and docker-compose(Y/n):"
read docker
if [ $docker == "Y" ]
then
	# Install Gatsby
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi

echo "Installing zsh"
sudo apt install zsh

echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing Powerline10k Theme"
# Powerline10k Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Installing Oh-My-Zsh Plugins"
# Oh-My-Zsh Plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Setting default shell to zsh"
chsh -s $(which zsh)

echo "All set!!! Please restart your WSL, from power shell run: wslconfig /t Ubuntu"
