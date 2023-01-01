#!/usr/bin/env sh

# [$]> ls -la ~/ExternalBackup
# [$]> ls -la ~/ExternalBackup/dotfiles

# rsync flags
# https://linux.die.net/man/1/rsync
# -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
# -D                          same as --devices --specials [--devices preserve device files (super-user only)] [--specials preserve special files]
# -g, --group                 preserve group
# -l, --links                 copy symlinks as symlinks
# -o, --owner                 preserve owner (super-user only)
# -p, --perms                 preserve permissions
# -r, --recursive             recurse into directories
# -t, --times                 preserve modification times
# -v, --verbose               increase verbosity

dotfiles_to_ignore=(
  .ansible
  .bash_sessions
  .cache
  .CFUserTextEncoding
  .cocoapods
  .cuegenerator
  .DS_Store
  .IdentityService
  .ServiceHub
  .Trash
)

rsync -av ~/.[^.]* --exclude=$dotfiles_to_ignore ~/ExternalBackup/dotfiles

for file in ${dotfiles_to_ignore[@]}; do
  rm -rf ~/ExternalBackup/dotfiles/$file
done
