#!/usr/bin/env sh

# [$]> ls -la /Volumes/AndrewHD
# [$]> ls -la /Volumes/AndrewHD/Andrews-iMac

external_volume='AndrewHD'
local_hostname=$(scutil --get LocalHostName) # Andrews-iMac

rsync -av ~/Downloads/ "/Volumes/$external_volume/$local_hostname/Downloads 2022"
rsync --remove-source-files -av ~/Downloads/ "/Volumes/$external_volume/$local_hostname/Downloads 2022"
