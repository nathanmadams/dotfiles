#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                      # dotfiles directory
olddir=~/dotfiles_old               # old dotfiles backup directory
files="profile bashrc"    # list of files/folders to symlink in homedir

##########
# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    if [ -f "~/.$file" ]; then
        mkdir -p $olddir
        echo "Backing up $file to $olddir"
        mv ~/.$file $olddir
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

############################
# Configure git
############################
echo "Enter first and last name for git:"
read fullname
echo "Enter email address for git:"
read email

git config --global user.name ${fullname}
git config --global user.email ${email}
git config --global rerere.enabled true
git config --global core.editor "/usr/bin/vim"
