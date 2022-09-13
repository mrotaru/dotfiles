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
 .npmrc
 )

# MD5 is used to determine whether files are the same
MD5=md5sum
(command -v $MD5 > /dev/null 2>&1;) || MD5=md5
(command -v $MD5 > /dev/null 2>&1;) || { echo "md5 command not installed; exiting"; exit 1; }
function md5 () {
  echo $($MD5 $1 | awk '{print $1}')
}

# files that were overwritten will be copied to a backup folder
backup_dir="$HOME/dotfiles-backup-$(date +"%Y-%m-%dT%k-%M")"

if [ -x "$(command -v git)" ]; then
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
   
  # repo cloned; now link dotfiles to the ones in repo, creating backups for user_file files
  for file in "${!files[@]}"; do
      user_file="$HOME/${files[file]}"
      repo_file="$HOME/dotfiles/${files[file]}"

      if [ -f "$user_file" -o -h "$user_file" ]; then
          # compute md5 checksums
          md5_user_file=$(md5 $user_file)
          md5_repo_file=$(md5 $repo_file)

          # if different, create backup and remove user_file file; then create link
          if [ "$md5_user_file" != "$md5_repo_file" ]; then
              echo "\"$user_file\" exists and is different from \"$repo_file\","
              echo "copying to \"$backup_dir\"..."
              [ ! -d "$backup_dir" ] && mkdir "$backup_dir"
              cp "$user_file" "$backup_dir" || { echo "Could not backup, exiting..."; exit 1; }
              echo "removing \"$user_file\"..."
              rm "$user_file" || { echo "Could not remove $user_file, exiting..."; exit 1; }
              ln -s "$repo_file" "$user_file"
          else
              echo "\"$user_file\" exists but is the same as \"$repo_file\" (md5: $md5_user_file)"
          fi
      else
          echo "creating link to $repo_file..."
          ln -s "$repo_file" "$user_file" || { echo "failed to create link \"$repo_file\", exiting."; exit 1; }
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
      user_file="$HOME/${files[file]}"
      repo_file="~/dotfiles/${files[file]}"
      repo_file_url="${source_root}/${files[file]}"
      if [ -f "$repo_file" -o -h "$repo_file" ]; then
          # compute md5 checksums
          md5_user_file=$(md5 "$user_file")

          # download new file to tmp dir
          tmp_file_path="$tmp_dir/${files[file]}"
          echo "downloading $repo_file_url to $tmp_file_path..."
          case "$get_method" in
              "curl") cd $tmp_dir && { curl -O $repo_file_url ; cd -; } ;;
              "wget") wget --no-verbose "$repo_file_url" -O "$tmp_file_path" ;;
          esac
          md5_new=$(md5 $tmp_file_path)

          # if different, create backup and remove repo_file file; then create link
          if [ "$md5_user_file" != "$md5_new" ]; then
              echo "\"$user_file\" exists and is different from \"$tmp_file_path\","
              echo "copying $user_file to \"$backup_dir\"..."
              [ ! -d "$backup_dir" ] && mkdir "$backup_dir"
              cp "$user_file" "$backup_dir" || { echo "Could not backup, exiting..."; exit 1; }
              echo "removing \"$user_file\"..."
              rm "$user_file" || { echo "Could not remove $user_file, exiting..."; exit 1; }
              echo "copying \"$tmp_file_path\" to \"$repo_file\"..."
              cp $tmp_file_path $repo_file
              echo "linking $user_file to \"$repo_file\"..."
              ln -s "$user_file" "$repo_file"
          else
              echo "\"$repo_file\" exists but is the same as \"$new\" (md5: $md5_user_file)"
          fi
      else
          echo "creating link to $repo_file..."
          ln -s "$repo_file" "$user_file" || { echo "failed to create link \"$user_file\", exiting."; exit 1; }
      fi
  done

  rm -rf $temp_dir

  [ -f "$HOME/.profile" ] && source "$HOME/.profile"
fi
