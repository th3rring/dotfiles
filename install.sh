#!/bin/bash
# Thomas Herring 2021

printf '###### Setting up preferences ######\n\n\n'

INSTALL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USER_HOME=$HOME

# Make sure user path is correct.
if [ $USER = 'root' ]
then
  USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
fi

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
apt_programs='tmux vim sshpass git htop clang clang-tidy cmake meson ninja-build curl python3-pip deja-dup'
install_apt_progs () {
	echo "Installing apt programs..."
	check_root
	sudo apt install -y $apt_programs
}
prompt_user install_apt_progs "Would you like to install apt programs?"


pip_programs='ranger-fm rocker'
install_pip_progs () {
	echo "Installing pip programs..."
	pip3 install $pip_programs --user
}
prompt_user install_pip_progs "Would you like to install pip programs?"

# Programs on snap to install
snap_programs='discord libreoffice spotify gimp'
install_snap_progs () {
	echo "Installing apt programs..."
	check_root
	sudo snap install $snap_programs

	# Have to specify --classic packages here
	sudo snap install android-studio --classic
	sudo snap install slack --classic
}
prompt_user install_snap_progs "Would you like to install snap programs?"

install_suckless () {
        echo "Installing Suckless tools..."
        git -C $INSTALL_PATH submodule update --init --recursive
        check_root
        sudo apt install suckless-tools dwm libx11-dev libxft-dev libxinerama-dev nitrogen
        sudo make -C "$INSTALL_PATH/suckless/dwm" clean install
        sudo make -C "$INSTALL_PATH/suckless/dwmblocks" clean install
        sudo make -C "$INSTALL_PATH/suckless/st" clean install

        ln -sfn "$INSTALL_PATH/suckless/dwm" "$USER_HOME/.config/"
        ln -sfn "$INSTALL_PATH/suckless/dwmblocks" "$USER_HOME/.config/"
        ln -sfn "$INSTALL_PATH/suckless/st" "$USER_HOME/.config/"

        # Install picom.
        sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev

        picom_loc=$USER_HOME/.config/picom
        git clone https://github.com/yshui/picom.git $picom_loc
        git -C $picom_loc submodule update --init --recursive
        meson --buildtype=release $picom_loc $picom_loc/build
        ninja -C $picom_loc/build
        ninja -C $picom_loc/build install

        ln -sfn "$INSTALL_PATH/picom.conf" $picom_loc

        bash $INSTALL_PATH/statusbar/link.sh

        if ! command -v gsettings &> /dev/null
        then
          gsettings set org.gnome.desktop.default-applications.terminal exec st
        fi
}
prompt_user install_suckless "Would you like to install Suckless tools?"

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
install_fonts () {
	echo 'Installing fonts...'
	git clone https://github.com/ryanoasis/nerd-fonts.git $INSTALL_PATH/nerd-fonts

        # If we're running as root, make sure to install as user.
	if [ $USER = 'root' ]
	then
          sudo -u $SUDO_USER bash $INSTALL_PATH/nerd-fonts/install.sh
          echo 'Installing Jetbrains mono'
          sudo apt install fonts-jetbrains-mono
        else
          bash $INSTALL_PATH/nerd-fonts/install.sh
	fi

  rm -rf $INSTALL_PATH/nerd-fonts

  wget -O $INSTALL_PATH/JetBrainsMono-2.242.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
  unzip JetBrainsMono-2.242.zip

  # If we're running as root, make sure to install as user.
	if [ $USER = 'root' ]
	then
          sudo mv fonts/ttf/JetBrainsMono-*.ttf /usr/share/fonts/
        else
          mv fonts/ttf/JetBrainsMono-*.ttf $HOME/.local/share/fonts/
	fi

  rm -rf $INSTALL_PATH/JetBrainsMono-2.242

  # If we're running as root, make sure to install as user.
	if [ $USER = 'root' ]
	then
          sudo mv fonts/ttf/JetBrainsMono-*.ttf /usr/share/fonts/
          sudo cp fonts/AppleColorEmoji.ttf /usr/share/fonts/
        else
          mv fonts/ttf/JetBrainsMono-*.ttf $HOME/.local/share/fonts/
          mv fonts/AppleColorEmoji.ttf $HOME/.local/share/fonts/
	fi

  rm -rf $INSTALL_PATH/JetBrainsMono-2.242

}
prompt_user install_fonts "Would you like to install fonts?"

# Install Vundle and install plugins
# Moved to Neovim, commenting out this.
# install_vim_plugins () {
# 	echo 'Installing Vundle and VIM plugins...'
# 	git clone https://github.com/VundleVim/Vundle.vim.git $USER_HOME/.vim/bundle/Vundle.vim
# 	rm -f $USER_HOME/.vimrc
# 	ln -s $INSTALL_PATH/vimrc $USER_HOME/.vimrc
# 	vim +PluginInstall +qall
# 	python3 $USER_HOME/.vim/bundle/YouCompleteMe/install.py --clangd-completer
# }
# prompt_user install_vim_plugins "Would you like to install vim plugins?"

# Install Neovim and plugins from personal repo.
# install_neovim () {
#   echo 'Installing Neovim from personal repo...'
#   sudo apt install neovim
#   bash <(curl -s https://raw.githubusercontent.com/th3rring/nvim/master/utils/install.sh)
# }

install_neovim () {
  # Old installation method.
  # echo 'Installing Neovim from latest release appimage...'
  # curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  # chmod u+x nvim.appimage
  # ./nvim.appimage --appimage-extract
  # # check_root
  # # TODO: Make this check that there isn't a directory already there.
  # sudo mv squashfs-root /
  # sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

  sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl
  git clone https://github.com/neovim/neovim.git $USER_HOME/.neovim
  cd $USER_HOME/.neovim
  sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install

  echo 'Checking if Lunarvim has been installed already...'
  if [ ! -d $USER_HOME/.local/share/lunarvim/lvim/utils/installer/ ]; then
	  echo 'Uninstalling...'
	  bash $USER_HOME/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
  fi

  echo 'Installing latest version of LunarVim...'
  sudo apt install -y python3-pip python-dev python3-dev python3.8-venv
  sudp apt install -y cargo npm composer php julia default-jre xclip
  LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)

  # Checking if user has already added personal config.
  if [ ! -d $USER_HOME/.config/lvim/.git/ ]; then

    # If not, remove existing config and clone new one.
    echo "Deleting default lvim config..."
    rm -rf $USER_HOME/.config/lvim

    echo "Cloning in LunarVim config repo..."
    git clone https://github.com/th3rring/lvim.git $USER_HOME/.config/lvim
  else
    echo "Lvim settings already replaced... Manually change if necessary"
  fi

  echo "Don't forget to run :PackerInstall and :PackerSync inside LunarVim!"
}
prompt_user install_neovim "Would you like to install neovim?"

install_lazygit () {
  echo 'Installing Lazygit with Go...'
  # check_root
  sudo apt update
  sudo apt install -y golang-go
  go get github.com/jesseduffield/lazygit
}
prompt_user install_lazygit "Would you like to install lazygit?"

# Install texlive for Neovim support.
install_latex () {
  echo 'Installing Latex...'
  sudo apt install texlive-full
}
prompt_user install_latex "Would you like to install latex?"

# Install docker using convenience scripts.
# Check if this requires sudo access.
install_docker () {
  echo 'Installing docker using convenience script...'
  bash <(curl -s https://get.docker.com)
}
prompt_user install_docker "Would you like to install docker?"


# Install tmux params
# Switched to using DWM and neovim so this isn't necessary.
install_tmux_plugins () {
	echo 'Installing Tmux plugins...'
	git clone https://github.com/samoshkin/tmux-config.git
	./tmux-config/install.sh
	rm -f $USER_HOME/.tmux.conf
	ln -s $INSTALL_PATH/tmux.conf $USER_HOME/.tmux.conf
}
# prompt_user install_tmux_plugins "Would you like to install tmux plugins?"

install_workspace () {
  echo 'Making workspace...'
  mkdir $USER_HOME/Workspace
  echo "export WORKSPACE_PATH=$USER_HOME/Workspace" >> $USER_HOME/.bashrc
}
prompt_user install_workspace "Would you like to make a workspace?"

# Install builder in workspace.
install_builder () {
  echo 'Installing builder...'
  git clone git@github.com:th3rring/builder.git $USER_HOME/Workspace/builder
  docker pull th3rring/builder -a
  echo "export BUILDER_PATH=$USER_HOME/Workspace/builder" >> $USER_HOME/.bashrc
}
# prompt_user install_builder "Would you like to install builder?"

# Install cling interpreter in dotfiles directory.
install_cling () {
	echo 'Installing cling...'
	echo 'Note: copying binaries for Ubuntu 20.04'
	wget https://root.cern.ch/download/cling/cling_2020-09-08_ROOT-ubuntu2004.tar.bz2
	tar -xvf cling_2020-09-08_ROOT-ubuntu2004.tar.bz2
	rm -f cling_2020-09-08_ROOT-ubuntu2004.tar.bz2
}
# prompt_user install_cling "Would you like to install cling?"


# Add bashrc source
install_commands () {
	echo 'Installing commands...'
	echo 'source '$INSTALL_PATH'/setup.bash' >> $USER_HOME/.bashrc
	source $USER_HOME/.bashrc
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

# TODO: Add section that makes workspace folder and git clones default scripts
printf '\n\n###### Done setup! ######\n'
