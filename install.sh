#!/bin/bash

programs='tmux vim sshpass git ctags htop'

function install_progs {
	echo "I'm installing programs"
	if [ $USER != 'root' ]
	then
		echo 'Not running as sudo, please authenticate.'
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
#git clone https://github.com/ryanoasis/nerd-fonts.git
#./nerd-fonts/install.sh
#rm -rf nerd-fonts


# Install Vundle and install plugins
echo 'Installing Vundle and VIM plugins...'
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#rm -f ~/.vimrc
#ln -s $PWD/vimrc ~/.vimrc
#vim +PluginInstall +qall

# Install tmux params
echo 'Installing Tmux'
#git clone https://github.com/samoshkin/tmux-config.git
#./tmux-config/install.sh
#rm -rf tmux-config
#rm -f ~/.tmux.conf
#ln -s $PWD/tmux.conf ~/.tmux.conf

# Add bashrc source
echo 'source '$PWD'/setup.bash' >> ~/.bashrc
