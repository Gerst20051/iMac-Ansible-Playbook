#!/usr/bin/env sh

# [$]> ls -la ~/ExternalBackup
# [$]> ls -la ~/ExternalBackup/dotfiles

files_to_move=(
  "$HOME/ansible-brainbase-dev-playbook"
  "$HOME/BACKUP - PP Mac Mini"
  "$HOME/BACKUP - PP MacBook Pro"
  "$HOME/Bash Files.zip"
  "$HOME/BrainbaseTeam"
  "$HOME/CoverageScript"
  "$HOME/Makefile"
  "$HOME/Old Bash Files"
  "$HOME/Web"
)

for file in "${files_to_move[@]}"; do
  cp -r "$file" "$HOME/ExternalBackup"
done

# for file in "${files_to_move[@]}"; do
#   rm -rf "$file"
# done
