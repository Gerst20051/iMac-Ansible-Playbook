#!/usr/bin/env sh

# [$]> ls -la /Volumes/AndrewHD
# [$]> ls -la /Volumes/AndrewHD/Andrews-iMac
# [$]> ls -la /Volumes/AndrewHD/Andrews-iMac/ExternalBackup

external_volume='AndrewHD'
local_hostname=$(scutil --get LocalHostName) # Andrews-iMac

# [$]> ls -la /Volumes/AndrewHD/Andrews-iMac/ExternalBackup/dotfiles
rsync -av ~/ExternalBackup/dotfiles /Volumes/$external_volume/$local_hostname/ExternalBackup
