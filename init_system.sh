#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the emacs files that came with this git checkout
# and stores them into you home directory under /Users/$(whoami)/
############################

########## Variables
user=$(whoami)
directory_for_dotfile=/Users/$user
backup_directory=/Users/$user/.backup_memacs

#ToDo: Maybe this should created dynamical.
files="emacs emacs.d"    # list of files/folders to symlink in homedir

##########

##check if backup diretory exists
[[ ! -d $backup_directory ]] && echo "Creating Backup diretory $backup_directory" && mkdir $backup_directory

##check if emacs file exists and copy to backup and remove afterwards
[[ -f $directory_for_dotfile/.emacs ]] && echo "Backup old .emacs file." && cp $directory_for_dotfile/.emacs $backup_directory && rm $directory_for_dotfile/.emacs
[[ -d $directory_for_dotfile/.emacs.d ]] && echo "Backup old .emacs.d directory." && cp -R $directory_for_dotfile/.emacs.d $backup_directory && rm -rf $directory_for_dotfile/.emacs.d

##now link files to home diretory
ln -s $(pwd)/.emacs $directory_for_dotfile && echo "Linked .emacs file to ~"
ln -s $(pwd)/.emacs.d $directory_for_dotfile && echo "Linked .emacs.d directory to ~"

echo "Finish, you can now enjoy you new emacs installation."
