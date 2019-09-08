#!/bin/bash

install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO: Add function to ask for user input and make each step optional

prompt_user () {
while true; do
    read -p "$2" yn
    case $yn in
        [Yy]* ) $1; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

}

# Programs on apt to install
# TODO: Add packages with PPAs like google-chrome
# TODO: Add packages that install with snap like spotify
programs='tmux vim sshpass git ctags htop snapd'

printf '###### Setting up preferences ######\n\n\n'

install_progs () {
	echo "Installing programs..."
	if [ $USER != 'root' ]
	then
		echo 'Not running as root, please authenticate.'
	fi
	sudo apt install $programs
}

prompt_user install_progs "Would you like to install workspace programs?"

# Add nerdfont install
install_nerdfonts () {
	echo 'Installing Nerdfonts...'
	git clone https://github.com/ryanoasis/nerd-fonts.git
	./nerd-fonts/install.sh
	rm -rf nerd-fonts
}
prompt_user install_nerdfonts "Would you like to install Nerdfonts?"

# Install Vundle and install plugins
install_vim_plugins () {
	echo 'Installing Vundle and VIM plugins...'
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	rm -f ~/.vimrc
	ln -s $install_path/vimrc ~/.vimrc
	# TODO: Compile YCM backend before installing plugins
	vim +PluginInstall +qall
}
prompt_user install_vim_plugins "Would you like to install vim plugins?"

# Install tmux params
install_tmux_plugins () {
	echo 'Installing Tmux plugins...'
	git clone https://github.com/samoshkin/tmux-config.git
	./tmux-config/install.sh
	rm -f ~/.tmux.conf
	ln -s $install_path/tmux.conf ~/.tmux.conf
}
prompt_user install_tmux_plugins "Would you like to install tmux plugins?"

# Add bashrc source
install_commands () {
	echo 'Installing commands...'
	echo 'source '$PWD'/setup.bash' >> ~/.bashrc
}
prompt_user install_commands "Would you like to install commands?"

# Ask to install vpn
install_vpn () {
	echo "Installing Rice vpn..."
	tar -xvf anyconnect.tar.gz
	if [ $USER != 'root' ]
	then
		echo 'Not running as root, please authenticate.'
	fi
	sudo ./anyconnect-linux64-4.7.00136/vpn/vpn_install.sh
	rm -rf anyconnect-linux64-4.7.00136
}
prompt_user install_vpn "Would you like to install Rice vpn?"

echo '###### Done setup! ######'
