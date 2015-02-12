#!/usr/bin/env sh

dotfiles="$HOME/.home"
vimfiles="$HOME/.vim"

# to error out
warn() {
  echo "$1" >&2
}

die() {
  warn "$1"
  exit 1
}

lnif() {
  if [ ! -e $2 ] ; then
    ln -s $1 $2
  fi
}

echo "Installing/Updating dotfiles...\n"

if [ ! -e $dotfiles/.git ]; then
  echo "Cloning dotfiles\n"
  git clone https://github.com/7kfpun/.home.git $dotfiles
else
  echo "Updating dotfiles\n"
  cd $dotfiles && git pull
fi

git checkout develop

# bash
echo "Setting up bash...\n"
lnif $dotfiles/config/bash/.bash_aliases $HOME/.bash_aliases
lnif $dotfiles/config/bash/.bash_functions $HOME/.bash_functions
lnif $dotfiles/config/bash/.bash_login $HOME/.bash_login
lnif $dotfiles/config/bash/.bash_logout $HOME/.bash_logout
lnif $dotfiles/config/bash/.bash_profile $HOME/.bash_profile
lnif $dotfiles/config/bash/.bashrc $HOME/.bashrc

# dev
echo "Setting up dev tools...\n"
lnif $dotfiles/config/.gitconfig $HOME/.gitconfig
lnif $dotfiles/config/.gitignore $HOME/.gitignore
lnif $dotfiles/config/.pylintrc $HOME/.pylintrc
lnif $dotfiles/config/.dir_colors $HOME/.dir_colors

echo "Installing/Updating vim\n"

if [ ! -e $vimfiles/.git ]; then
  echo "Cloning vimfiles\n"
  git clone https://github.com/7kfpun/.vim.git $vimfiles
else
  echo "Updating vimfiles\n"
  cd $vimfiles && git pull
fi

git checkout develop && git submodule update --init --recursive

# vim
echo "Setting up vim...\n"
lnif $vimfiles/.vimrc $HOME/.vimrc

echo "Update/Install plugins using NeoBundle"
vim +NeoBundleInstall +qall < /dev/tty # necessary to avoid vim: Input not from terminal warning

echo "Everything succesfully installed."
