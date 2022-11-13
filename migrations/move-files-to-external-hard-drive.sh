#!/usr/bin/env sh

# [$]> ls -la /Volumes/AndrewHD
# [$]> ls -la /Volumes/AndrewHD/Andrews-iMac

external_volume='AndrewHD'
local_hostname=$(scutil --get LocalHostName) # Andrews-iMac

# rsync -av ~/Downloads/ "/Volumes/$external_volume/$local_hostname/Downloads 2022"
# rsync --remove-source-files -av ~/Downloads/ "/Volumes/$external_volume/$local_hostname/Downloads 2022"

# rsync -av ~/Documents/ "/Volumes/$external_volume/$local_hostname/Documents 2022"
# rsync --remove-source-files -av ~/Documents/ "/Volumes/$external_volume/$local_hostname/Documents 2022"

# rsync -av ~/Dropbox/ "/Volumes/$external_volume/$local_hostname/Dropbox 2022"
# rsync --remove-source-files -av ~/Dropbox/ "/Volumes/$external_volume/$local_hostname/Dropbox 2022"

# directories_to_move_1=(
#   "ansible-brainbase-dev-playbook"
#   "BACKUP - PP Mac Mini"
#   "BACKUP - PP MacBook Pro"
#   "BrainbaseTeam"
#   "CoverageScript"
#   "Old Bash Files"
# )

# for directory in "${directories_to_move_1[@]}"; do
#   rsync -av "$HOME/$directory/" "/Volumes/$external_volume/$local_hostname/$directory"
#   rsync --remove-source-files -av "$HOME/$directory/" "/Volumes/$external_volume/$local_hostname/$directory"
# done

directories_to_move_2=(
  "Web"
)

# for directory in "${directories_to_move_2[@]}"; do
#   rsync -av "$HOME/$directory/" "/Volumes/$external_volume/$local_hostname/$directory"
#   # rsync --remove-source-files -av "$HOME/$directory/" "/Volumes/$external_volume/$local_hostname/$directory"
# done
