# Add directories to PATH
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:~/dropbox/bin:~/bin:~/Library/Python/3.6/bin:$PATH

# Add Scilab & Animal to PATH
export PATH=$PATH:/applications/scilab-5.5.1.app/contents/macos/bin
export PATH=$PATH:~/web/git/scilab/animal/bin
export ANIMAL_CONFIG=~/web/git/scilab/animal/config

# Add colors to terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# default ======exfxcxdxbxegedabagacad

# Turn on grep coloration
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Increase size of bash history
HISTFILESIZE=10000

export PASSPORT_APIKEY={{ passport_apikey }}
