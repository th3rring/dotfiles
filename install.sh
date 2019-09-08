#!/bin/bash

install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

programs='tmux vim sshpass git ctags htop'

function install_progs {
	echo "I'm installing programs"
	if [ $USER != 'root' ]
	then
		echo 'Not running as root, please authenticate.'
	fi
	sudo apt install $programs
}

printf '###### Setting up preferences ######\n\n\n'
while true; do
    read -p "Would you like to install workspace programs?" yn
    case $yn in
        [Yy]* ) install_progs; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Add nerdfont install
echo 'Installing Nerdfonts...'
git clone https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh
rm -rf nerd-fonts

# Install Vundle and install plugins
echo 'Installing Vundle and VIM plugins...'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -f ~/.vimrc
ln -s $install_path/vimrc ~/.vimrc
vim +PluginInstall +qall

# Install tmux params
echo 'Installing Tmux...'
git clone https://github.com/samoshkin/tmux-config.git
./tmux-config/install.sh
rm -f ~/.tmux.conf
ln -s $install_path/tmux.conf ~/.tmux.conf

# Add bashrc source
echo 'Installing commands...'
echo 'source '$PWD'/setup.bash' >> ~/.bashrc

# Ask to install vpn
function install_vpn {
	tar -xvf anyconnect.tar.gz
	if [ $USER != 'root' ]
	then
		echo 'Not running as root, please authenticate.'
	fi
	sudo ./anyconnect-linux64-4.7.00136/vpn/vpn_install.sh
	rm -rf anyconnect-linux64-4.7.00136
}
while true; do
    read -p "Would you like to install Rice vpn?" yn
    case $yn in
        [Yy]* ) install_vpn; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo '###### Done setup! ######'
