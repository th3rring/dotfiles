#!/bin/bash
# Thomas Herring

printf '###### Setting up preferences ######\n\n\n'

install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

check_root () {
	if [ $USER != 'root' ]
	then
		echo 'Not running as root, please authenticate.'
	fi
}

# Programs on apt to install
apt_programs='tmux vim sshpass git ctags htop snapd clang cmake steam-installer'
install_apt_progs () {
	echo "Installing apt programs..."
	check_root
	sudo apt install $apt_programs
}
prompt_user install_apt_progs "Would you like to install apt programs?"

# Programs on snap to install
snap_programs='docker discord libreoffice spotify gimp'
install_snap_progs () {
	echo "Installing apt programs..."
	check_root
	sudo snap install $snap_programs

	# Have to specify --classic packages here
	sudo snap install android-studio --classic
	sudo snap install slack --classic
}
prompt_user install_snap_progs "Would you like to install snap programs?"

# Install Chrome
install_chrome () {
	echo "Installing Google Chrome..."
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	check_root
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm -f google-chrome-stable_current_amd64.deb
}
prompt_user install_chrome "Would you like to install Google Chrome?"

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
	vim +PluginInstall +qall
	python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer
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
	check_root
	sudo ./anyconnect-linux64-4.7.00136/vpn/vpn_install.sh
	rm -rf anyconnect-linux64-4.7.00136
}
prompt_user install_vpn "Would you like to install Rice vpn?"

printf '\n\n###### Done setup! ######\n'
