# Collection Of Bash Aliases

# Add to grep: color, line numbers, context of 1 line
alias grep="grep --color -n -B 1"
alias grepword="grep -Hnr"
alias grepfiles="grep -l"
alias grepnot="grep -v"

# default add color to ls
# G - colorized output
# F - Visual Classification of Files With Special Characters
# a - show hidden files/folders
# l - list format
# h - print sizes in human readable format
alias ls="ls -GFalh"
alias sl="ls"

# The 'ls' family
# Add colors for filetype and human-readable sizes by default on 'ls':
alias lk="ls -lSr"   # Sort by size, biggest last
alias lt="ls -ltr"   # Sort by date, most recent last
alias lc="ls -ltcr"  # Sort by/show change time, most recent last
alias lu="ls -ltur"  # Sort by/show access time, most recent last
alias lr="ls -R"     # Recursive ls
alias la="\ls -A"    # Show hidden files
alias ll="\ls -l"    # List
alias l.="ls -d .*"  # Only show hidden files
alias lp="ls -p"     # Show folders

# a couple misc/simple commands
alias c="clear"
alias h="history"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias vi="vim"

# safe file operations
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias rd="\rm -r"
alias mkdir="mkdir -p"
alias rmdir="rmdir -p"

# pretty-print of PATH variable
alias path="echo -e ${PATH//:/\\\n}"

# print file permissions for ls
alias cls="ls -l | awk '{k = 0; for (i = 0; i <= 8; i++) k += ((substr(\$1, i + 2, 1)~/[rwx]/) * 2 ^ (8 - i)); if (k) printf(\"%0o \", k); print;}'"

# search for process
alias tm='ps -ef | grep'
alias psx='ps aux'
alias psr='ps -auroot'
alias psgerst='ps -augerst'

# show which commands you use the most
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# quick ssh to unc cs server
alias unc='ssh unc'
alias unc2='ssh unc2'
alias unctasks='unc "cat ~/tasks.txt"'

# git aliases
alias ga='git add'
alias ga.='git add .'
alias gaa='git add -A'
alias gu='git pull'
alias gp='git push'
#alias gl='git log --color --pretty=format:"%Cgreen%h %Creset %s %Cblueby %an (%ar) %Cred %d" --graph'
#alias glp='git log -p --color --pretty=format:"%Cgreen%h %Creset %s %Cblueby %an (%ar) %Cred %d" --graph'
alias gl='git log --color --graph --date=local --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr) %C(dim cyan)(%cd)%Creset %C(bold blue)<%an>%Creset%C(yellow)%d%Creset" --abbrev-commit'
alias glp='git log -p --color --graph --date=local --pretty=format:"%Cred%h%Creset - %s %Cgreen(%cr) %C(dim cyan)(%cd)%Creset %C(bold blue)<%an>%Creset%C(yellow)%d%Creset" --abbrev-commit'
alias gsl='git shortlog -sne'
alias gs='git status'
alias gh='git show --color'
alias gd='git diff --color'
alias gdw='git diff -w --color'
alias gdtw='git diff --ignore-space-at-eol --color'
alias gds='git diff --stat --color'
alias gdc='git diff --cached --color'
alias gdcw='git diff -w --cached --color'
alias gdctw='git diff --ignore-space-at-eol --cached --color'
alias gm='git commit -m'
alias gma='git commit -am'
alias gmd='git commit --amend'
alias gb='git branch'
alias gbs='git for-each-ref --sort=-committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"'
alias gc='git checkout'
alias gcp='git cherry-pick'
alias gcpn='git cherry-pick --no-commit'
alias gra='git remote add'
alias grr='git remote rm'
alias grc='git rm --cached'
alias gpu='git pull'
alias gcl='git clone'
alias gri='git rebase -i --autosquash'
alias grhard='git reset --hard HEAD^'
alias grsoft='git reset --soft HEAD^'
alias grmixed='git reset --mixed HEAD^'
alias grmerge='git reset --merge ORIG_HEAD'
alias grapply='git commit -C ORIG_HEAD'
alias gslist='git stash list --pretty=format:"%gd %Cblue%h %Cred* %C(yellow)%s"'
alias fix='git diff --name-only | uniq | xargs sublime'

# Xcode Aliases
alias purgeallbuilds='rm -rf ~/Library/Developer/Xcode/DerivedData/*'

# XAMPP Aliases
alias xampp='sudo /applications/xampp/xamppfiles/xampp'

# Misc cURL Utilities
alias ip='curl whatismyip.org'

# HTTP Aliases
alias http='curl http://echo.httpkit.com'
alias http1='http "/path?query=string"'
alias http2='http -i'

# Brew Aliases
alias fix_brew='sudo chown -R $USER /usr/local/'

# CD Aliases Dropbox
alias cdphil='cd ~/dropbox/school/phil 160'
alias cdphilnotes='cd ~/dropbox/school/phil 160/notes'

# CD Aliases Web/Git
alias cdgit='cd ~/Web/Git'
alias cddot='cd ~/Web/Git/dotfiles'
alias cdhack='cd ~/Web/Git/Hackathons'
alias cdwave='cd ~/Web/Git/HnS-Wave/src'
alias cdnetai='cd ~/Web/Git/HnS-Netai/src'
alias cdjs='cd ~/Web/Git/JavaScript'

# CD Aliases Web/Passport
alias cdwpassport='cd ~/Web/PP'

# CD Aliases Passport
alias cdpassport='cd ~/PP'

# Misc
alias cl='fc -e - | pbcopy' # copy output of last command to clipboard
alias cpu='top -o cpu' # top cpu
alias cpwd='pwd | tr -d "\n" | pbcopy' # copy the working directory path
alias flush='sudo killall -HUP mDNSResponder' # DNS Update
alias mem='top -o rsize' # top memory
alias stfu='osascript -e "set volume output muted true"' # mute the system volume
alias tn='tr -d "\n"' # trim newlines
alias todos='ack -n --nogroup "(TODO|FIX(ME)?):"' # list TODO/FIX lines from the current project

# Open Aliases
alias open.coverage='open coverage/lcov-report/index.html' # open coverage report in browser
alias open.coverage.folder='open coverage/lcov-report' # open coverage report folder in finder
alias open.coverage.watch='browser-sync start --files=coverage/lcov-report/index.html --server --startPath coverage/lcov-report/ --port=11111' # open coverage report in browser with browser-sync

# Jest Aliases (Tests / Coverage)
alias jest='NODE_ENV=test AWS_REGION=localRegion node_modules/jest/bin/jest.js'
alias jest.silent='jest --silent'
alias jest.watch='jest --watch'
alias jest.watch.silent='jest --watch --silent'
alias jest.coverage='jest --coverage --silent'
alias jest.coverage.verbose='jest --coverage'
alias jest.coverage.watch='jest --coverage --silent --watch'
alias jest.coverage.watch.verbose='jest --coverage --watch'
alias jest.coverage.watch.summary='jest --coverage --silent --watch --coverageReporters=text-summary --coverageReporters=lcov'
alias jest.coverage.watch.summary.verbose='jest --coverage --watch --coverageReporters=text-summary --coverageReporters=lcov'

# Passport Misc Aliases
alias generate_serverless_profile='~/Web/PP/DevOps/build-utils/scripts/aws-mk-sts-profile.sh -t developer-dev -n serverless' # create temporary aws credentials profile
alias npm_run_start_local='DEBUG=* npm run start -- --target=local --region=us-east-1'
alias npm_run_docker_mysql_init='NODE_ENV=test npm run docker:mysql:init'

# Provision Script
alias provision='ansible-playbook -v ~/iMac-Ansible-Playbook/playbook.yml -i ~/iMac-Ansible-Playbook/inventory --ask-become-pass'

# Sudo Aliases (Root User has UID of 0 in /etc/group)
if [ $UID -ne 0 ]; then
    alias reboot='sudo reboot'
fi
