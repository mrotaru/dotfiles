#!/bin/bash

# - if git is installed, clone dotfiles repo with git
# - else, use either curl or wget to download each dotfile
# - for every dotfile, if one already exists, create a backup
# - link dotfiles to downloaded/cloned ones in ~/dotfiles

# which files are to be copied
files=(
 .bashrc
 .bash_interactive
 .bash_profile
 .bash_aliases
 .bash_functions
 .inputrc
 .profile
 .screenrc
 .gitconfig
 .tmux.conf
 .ackrc
 .i3
 )

# MD5 is used to determine whether files are the same
MD5=md5sum
(command -v $MD5 > /dev/null 2>&1;) || MD5=md5
(command -v $MD5 > /dev/null 2>&1;) || { echo "md5 command not installed; exiting"; exit 1; }
function md5 () {
  sum= eval($MD5  $1 | awk '{print $1}') || { echo "failed to compute md5, exiting."; exit 1; }
  echo $sum
}

# files that were overwritten will be copied to a backup folder
backup_dir="$HOME/dotfiles-backup-$(date +"%Y-%m-%dT%k-%M")"

# if git is installed, use git to clone the dotfiles repo
if [ command -v git >/dev/null 2>&1 ]; then
  echo "git found..."
  if [ -d ~/dotfiles ]; then 
      echo "~/dotfiles already exists, trying to git pull...";
      cd ~/dotfiles && git pull || exit 1;
  else
      REPO="mrotaru/dotfiles.git"
      echo "Cloning $REPO..."
      git clone git@github.com:$REPO ~/dotfiles >/dev/null 2>&1  || {
        echo "Could not clone via SSH, trying HTTPS..."
        git clone https://github.com/mrotaru/dotfiles.git >/dev/null 2>&1 || { echo "Failed to clone, exiting."; exit 1; }
      }
  fi
   
  # repo cloned; now link dotfiles to the ones in repo, creating backups for existing files
  for file in "${!files[@]}"; do
      existing="$HOME/${files[file]}"
      new="$HOME/dotfiles/${files[file]}"

      if [ -f "$existing" -o -h "$existing" ]; then
          # compute md5 checksums
          md5_existing=$(md5 $existing)
          md5_new=$(md5 $new)

          # if different, create backup and remove existing file; then create link
          if [ "$md5_existing" != "$md5_new" ]; then
              echo "\"$existing\" exists and is different from \"$new\","
              echo "copying to \"$backup_dir\"..."
              [ ! -d "$backup_dir" ] && mkdir "$backup_dir"
              cp "$existing" "$backup_dir" || { echo "Could not backup, exiting..."; exit 1; }
              echo "removing \"$existing\"..."
              rm "$existing" || { echo "Could not remove $existing, exiting..."; exit 1; }
              ln -s "$new" "$existing"
          else
              echo "\"$existing\" exists but is the same as \"$new\" (md5: $md5_existing)"
          fi
      else
          echo "creating link to $new..."
          ln -s "$new" "$existing" || { echo "failed to create link \"$new\", exiting."; exit 1; }
      fi
  done
else
  # no git; set download method - curl or wget
  echo "git not found, downloading dotfiles with curl/wget..."
  command -v curl >/dev/null 2>&1
  if [ $? -eq 0 ]; then
     get_method="curl"
  else
      command -v wget >/dev/null 2>&1
      [ $? -eq 0 ] && get_method="wget"
  fi

  [ -z "$get_method" ] && { echo "Neither wget nor curl found. Exiting..."; exit 1; }

  # backups folder - to be used for files which already exist
  backup_dir=$(date +"%Y-%m-%dT%k-%M")

  # link to raw files
  source_root="https://raw.githubusercontent.com/mrotaru/dotfiles/master"

  temp_dir=$(mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir')

  # go to ~/dotfiles directory and fetch the files
  [ ! -d ~/dotfiles ] && mkdir ~/dotfiles
  cd ~/dotfiles
  for file in "${!files[@]}"; do
      src="${source_root}/${files[file]}"
      dest="~/dotfiles/${files[file]}"
      existing="~/${files[file]}"
      if [ -f "$dest" -o -h "$dest" ]; then
          # compute md5 checksums
          md5_existing=$(md5 "$existing")

          # download new file to tmp dir
          tmp_file_path="$tmp_dir/${files[file]}"
          echo "downloading $src to $tmp_file_path..."
          case "$get_method" in
              "curl") cd $tmp_dir && { curl -O $src ; cd -; } ;;
              "wget") wget --no-verbose "$src" -O "$tmp_file_path" ;;
          esac
          md5_new=$(md5 $tmp_file_path)

          # if different, create backup and remove dest file; then create link
          if [ "$md5_existing" != "$md5_new" ]; then
              echo "\"$existing\" exists and is different from \"$tmp_file_path\","
              echo "copying $existing to \"$backup_dir\"..."
              [ ! -d "$backup_dir" ] && mkdir "$backup_dir"
              cp "$existing" "$backup_dir" || { echo "Could not backup, exiting..."; exit 1; }
              echo "removing \"$existing\"..."
              rm "$existing" || { echo "Could not remove $existing, exiting..."; exit 1; }
              echo "copying \"$tmp_file_path\" to \"$dest\"..."
              cp $tmp_file_path $dest
              echo "linking $existing to \"$dest\"..."
              ln -s "$existing" "$dest"
          else
              echo "\"$dest\" exists but is the same as \"$new\" (md5: $md5_existing)"
          fi
      else
          echo "creating link to $dest..."
          ln -s "$existing" "$dest" || { echo "failed to create link \"$existing\", exiting."; exit 1; }
      fi
  done

  rm -rf $temp_dir

  [ -f "$HOME/.profile" ] && source "$HOME/.profile"
fi
