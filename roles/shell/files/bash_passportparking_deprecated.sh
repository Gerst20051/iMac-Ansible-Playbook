# PassportParking Deprecated Aliases

# Monitor XAMPP Error Log With The Search Phrase As The First Argument
function fslog {
    tail -f /Applications/XAMPP/logs/php_error_log | grep "$1"
}

# VBoxManage
alias startvbimage="VBoxManage startvm 'Ubuntu 14.04 LTS Server' --type headless"
alias stopvbimage="VBoxManage controlvm 'Ubuntu 14.04 LTS Server' poweroff"
alias rebootvbimage="VBoxManage controlvm 'Ubuntu 14.04 LTS Server' reset"

# Push Bug Branch To Gitlab
function pushbug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git push origin andrew/"$1"
}

# Force Push Bug Branch To Gitlab
function pushbugforce {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git push -f origin andrew/"$1"
}

# Checkout Bug Branch From Production Branch
function newbug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    echo $1 | grep -E -q '^[0-9]+$'
    if [ $? -ne 0 ]; then
        echo "Numeric argument required, $1 provided"
        return
    fi
    git checkout production &&
    git pull --rebase origin production &&
    git checkout -b andrew/"$1"
}

# Checkout Bug Branch From Production Branch
function newbug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout production &&
    git pull --rebase origin production &&
    git checkout -b andrew/"$1"
}

# Checkout Bug Branch From Develop Branch
function newswiftbug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout develop &&
    git pull --rebase origin develop &&
    git checkout -b andrew/"$1"
}

# Sync Bug Branch With Production Branch
function syncbug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout production &&
    git pull --rebase origin production &&
    git checkout andrew/"$1" &&
    git merge --no-ff -m "Merge branch production into 'andrew/$1'" production
}

# Rebase Bug Branch With Production Branch
function rebasebug {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout production &&
    git pull --rebase origin production &&
    git checkout andrew/"$1" &&
    git rebase production
}

# Sync Bug Branch With Staging Branch
function syncbugstag {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout staging &&
    git pull --rebase origin staging &&
    git checkout andrew/"$1" &&
    git merge --no-ff -m "Merge branch staging into 'andrew/$1'" staging
}

# Sync Staging Branch With Production Branch
function syncstagwithprod {
    git checkout production &&
    git pull --rebase origin production &&
    git checkout staging &&
    git pull --rebase origin staging &&
    git merge --no-ff -m "Syncing staging branch with production branch" production &&
    git push origin staging
}

# Commit Bug Branch Changes With An Optional Commit Message
function mergebug {
    if [ "$#" != "1" -a "$#" != "2" ]; then
        echo "Illegal number of arguments, $# provided"
        return
    fi
    git checkout andrew/"$1"
    if [ "$#" == "1" ]; then
        git commit -m "$1"
    else
        git commit -m "$1 '$2'"
    fi
}

# Merge Bug Branch Commits Into Stag and Prod Branches
function mergeall {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
        mergestag "$@" &&
        mergeprod "$@"
}

# Merge Bug Branch Commits Into Master Branch
function mergemaster {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git checkout master &&
    git pull origin master &&
    git merge --no-ff -m "Merge branch 'andrew/$1' into master" andrew/"$1" &&
    git push origin master &&
    git checkout andrew/"$1"
}

# Merge Bug Branch Commits Into Development Branch
function mergedev {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git checkout development &&
    git pull origin development &&
    git merge --no-ff -m "Merge branch 'andrew/$1' into development" andrew/"$1" &&
    git push origin development &&
    git checkout andrew/"$1"
}

# Merge Bug Branch Commits Into Develop Branch
function mergedevelop {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git checkout develop &&
    git pull origin develop &&
    git merge --no-ff -m "Merge branch 'andrew/$1' into develop" andrew/"$1" &&
    git push origin develop &&
    git checkout andrew/"$1"
}

# Merge Bug Branch Commits Into Staging Branch
function mergestag {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git checkout staging &&
    git pull origin staging &&
    git merge --no-ff -m "Merge branch 'andrew/$1' into staging" andrew/"$1" &&
    git push origin staging &&
    git checkout andrew/"$1"
}

# Merge Bug Branch Commits Into Production Branch
function mergeprod {
    if [ "$#" -ne 1 ]; then
        echo "1 argument required, $# provided"
        return
    fi
    git checkout andrew/"$1" &&
    git checkout production &&
    git pull origin production &&
    git merge --no-ff -m "Merge branch 'andrew/$1' into production" andrew/"$1" &&
    git push origin production &&
    git checkout andrew/"$1"
}

# Sync Staging Branch With Production Branch For All Repos
function syncstagrepos {
    pwd=${PWD}
    remote="origin"
    repos=(
        'custom'
        'delayedproc'
        'mobile'
        'mobilepayweb'
        'mobilepaywin'
        'notifications'
        'opmgmt'
        'parkmonitor'
        #'paymentgateway'
        'rate'
        'shared'
        #'strings'
        #'tlotest'
        'validation-old'
        'violations'
    )
    if (( $# != 0 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    echo "Syncing Staging With Production For Repos: ${repos[@]}"
    sleep 2
    for repo in "${repos[@]}"; do
        echo $'\n\E[31m'
        message="Syncing Staging With Production For Repo '"
        message+=$'\E[36m'
        message+=$repo
        message+=$'\E[31m'
        message+="'"
        message+=$'\E[37m'
        echo $message
        \cd ~/PP/Code/$repo &&
        syncstagwithprod
        sleep 2
    done
    echo $'\n\n\E[31m'
    message="Finished Syncing Staging With Production For All Repos! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    cd ${pwd}
}

# Sync Stag and Prod Branches, Master, OR Dev Branch For All Repos
function syncrepos {
    pwd=${PWD}
    remote="origin"
    repos=(
        #'centralpay'
        #'centralpaydevice'
        'custom'
        'delayedproc'
        #'initscripts'
        #'kegerator'
        'migration'
        'mobile'
        #'mobileapp'
        'mobilepayweb'
        #'mobilepaywin'
        'notifications'
        'opmgmt'
        'parkmonitor'
        #'paymentgateway'
        'ppconfig'
        #'produpdate'
        'rate'
        #'rmc'
        #'reservations'
        #'sandbox'
        'shared'
        #'strings'
        #'test'
        #'testing'
        #'tlotest'
        'validation-old'
        'violations'
    )
    if (( $# != 0 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    echo "Syncing Repos: ${repos[@]}"
    sleep 2
    for repo in "${repos[@]}"; do
        echo $'\n\E[31m'
        message="Syncing Repo '"
        message+=$'\E[36m'
        message+=$repo
        message+=$'\E[31m'
        message+="' Branches"
        message+=$'\E[37m'
        echo $message
        function="syncbranches"
        if [[
            #$repo == "centralpay" ||
            #$repo == "centralpaydevice" ||
            #$repo == "initscripts" ||
            #$repo == "kegerator" ||
            #$repo == "mobileapp" ||
            #$repo == "operator" ||
            $repo == "ppconfig" ||
            #$repo == "produpdate" ||
            #$repo == "reservations" ||
            $repo == "sandbox"
            #$repo == "test" ||
            #$repo == "testing"
        ]]; then
            function="syncmasterbranch"
        fi
        if [[
            $repo == "migration"
        ]]; then
            function="syncdevbranch"
        fi
        \cd ~/PP/Code/$repo &&
            ${function}
            sleep 2
    done
    echo $'\n\n\E[31m'
    message="Finished Syncing All Repo Branches! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    cd ${pwd}
}

# Sync Stag and Prod Branches, Master, OR Dev Branch For All Repos
function syncrepos {
    pwd=${PWD}
    remote="origin"
    repos=(
        #'centralpay'
        #'centralpaydevice'
        'custom'
        'delayedproc'
        #'initscripts'
        #'kegerator'
        'migration'
        'mobile'
        #'mobileapp'
        'mobilepayweb'
        #'mobilepaywin'
        'notifications'
        'opmgmt'
        'parkmonitor'
        #'paymentgateway'
        'ppconfig'
        #'produpdate'
        'rate'
        #'rmc'
        #'reservations'
        #'sandbox'
        'shared'
        #'strings'
        #'test'
        #'testing'
        #'tlotest'
        'validation-old'
        'violations'
    )
    if (( $# != 0 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    echo "Syncing Repos: ${repos[@]}"
    sleep 2
    for repo in "${repos[@]}"; do
        echo $'\n\E[31m'
        message="Syncing Repo '"
        message+=$'\E[36m'
        message+=$repo
        message+=$'\E[31m'
        message+="' Branches"
        message+=$'\E[37m'
        echo $message
        function="syncbranches"
        if [[
            $repo == "ppconfig" ||
            $repo == "sandbox"
        ]]; then
            function="syncmasterbranch"
        fi
        if [[
            $repo == "migration"
        ]]; then
            function="syncdevbranch"
        fi
        \cd ~/PP/Code/$repo &&
            ${function}
            sleep 2
    done
    echo $'\n\n\E[31m'
    message="Finished Syncing All Repo Branches! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    cd ${pwd}
}

# Lsyncd Aliases (VirtualBox Server Syncing)
alias lsyncdcustom="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repocustom.lua'"
alias lsyncddp2="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repodelayedproc2.lua'"
alias lsyncdmpw="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repomobilepayweb.lua'"
alias lsyncdmobile="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repomobile.lua'"
alias lsyncdnot="sudo lsyncd '/Users/passport/lsyncd/ppconfig/reponotifications.lua'"
alias lsyncdopmgmt="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repoopmgmt.lua'"
alias lsyncdpm="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repoparkmonitor.lua'"
alias lsyncdpg="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repopaymentgateway.lua'"
alias lsyncdppc="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repoppconfig.lua'"
alias lsyncdrate="sudo lsyncd '/Users/passport/lsyncd/ppconfig/reporate.lua'"
alias lsyncdshared="sudo lsyncd '/Users/passport/lsyncd/ppconfig/reposhared.lua'"
alias lsyncdstrings="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repostrings.lua'"
alias lsyncdvalidation="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repovalidation.lua'"
alias lsyncdviolations="sudo lsyncd '/Users/passport/lsyncd/ppconfig/repoviolations.lua'"

# Sync Superpassport To Staging
alias rsync_opsman_stag="rsync -av --delete ~/PP/Eclipse/SuperPassportWorkspace/superpassport/opmgmt/main/OperatorMain/war/ easypparking:~/v2/opsman/"
alias rsync_opsman_prod="rsync -av --delete ~/PP/Eclipse/SuperPassportWorkspace/superpassport/opmgmt/main/OperatorMain/war/ easypparking:~/v2/opsmanprod/"

# Start SSHFS
alias start_sshfs="sshfs vbimage:/home/passport/ ~/PP/VBImage/"

# Start SSH Tunnels
function start_tunnels {
    kill_tunnels
    echo $'\E[36m'
    echo "Starting Tunnels"
    ssh -f -L 8080:localhost:80 ppinfo -N
    ssh -f -L 8181:localhost:80 easypparking -N
    ssh -f -L 8282:localhost:80 myeasyp -N
    ssh -f -L 8383:localhost:8080 myeasyp -N
    ssh -f -L 8484:localhost:80 cseasyp -N
    echo $'\E[33m'
    echo "All Tunnels Have Been Started!"
}

# Start SSH Tunnels
function start_tunnels {
    kill_tunnels
    echo $'\E[36m'
    echo "Starting Tunnels"
    ssh -f -L 8080:localhost:80 ppinfo -N
    ssh -f -L 9999:localhost:9999 ppinfo -N
    ssh -f -L 8181:localhost:80 easypparking -N
    echo $'\E[33m'
    echo "All Tunnels Have Been Started!"
    echo $'\E[37m'
}

# Kill SSH Tunnels
function kill_tunnels {
    ports=('8080' '8181' '8282' '8383' '8484')
    echo $'\E[31m'
    echo "Killing Tunnels: ${ports[@]}"
    echo $'\E[37m'
    for port in "${ports[@]}"; do
        pid=$(pgrep -f $port":localhost")
        if [[ "$pid" -gt 0 ]]; then
            kill $pid
            message=$'\E[35m'
            message+="Killed Tunnel With Port: '"
            message+=$'\E[36m'
            message+=$port
            message+=$'\E[35m'
            message+="' and PID: '"
            message+=$'\E[36m'
            message+=$pid
            message+=$'\E[35m'
            message+="'"
            message+=$'\E[37m'
            echo $message
        fi
    done
    echo $'\E[33m'
    echo "All Tunnels Have Been Killed!"
}

# Kill SSH Tunnels
function kill_tunnels {
    ports=('8080' '9999' '8181')
    echo $'\E[31m'
    echo "Killing Tunnels: ${ports[@]}"
    echo $'\E[37m'
    for port in "${ports[@]}"; do
        pid=$(pgrep -f $port":localhost")
        if [[ "$pid" -gt 0 ]]; then
            kill $pid
            message=$'\E[35m'
            message+="Killed Tunnel With Port: '"
            message+=$'\E[36m'
            message+=$port
            message+=$'\E[35m'
            message+="' and PID: '"
            message+=$'\E[36m'
            message+=$pid
            message+=$'\E[35m'
            message+="'"
            message+=$'\E[37m'
            echo $message
        fi
    done
    echo $'\E[33m'
    echo "All Tunnels Have Been Killed!"
    echo $'\E[37m'
}

# Find Tunnel Process
function find_tunnel {
    ps aux | grep ssh | grep "$1"
}

# Sync Repos With Virtual Box Image
function rsyncrepos {
    repolist=(
        'custom'
        'delayedproc2'
        'migration'
        'mobile'
        'mobilepayweb'
        'notifications'
        'opmgmt'
        'parkmonitor'
        'paymentgateway'
        'ppconfig'
        'rate'
        'shared'
        'validation'
        'violations'
    )
    rLen=${#repolist[@]}
    echo $'\n\E[35m'
    echo "Starting rsync for repos: ${repolist[@]}"
    echo $'\n'
    for (( i=0; i<${rLen}; i++ )); do
        echo $'\E[31m'
        remotepath=${repolist[$i]}
        if [[
            $remotepath == "notifications" ||
            $remotepath == "opmgmt"
        ]]; then
            remotepath="server/$remotepath"
        fi
        rsync -ave ssh --delete "${HOME}/Web/PP/Code/${repolist[$i]}/" vbimage:"~/workspace/$remotepath/"
        message="Started rsync for repo: '"
        message+=$'\E[36m'
        message+=${repolist[$i]}
        message+=$'\E[31m'
        message+="'"
        echo $message
        echo $'\E[37m'
    done
    echo $'\n\E[33m'
    echo "Rsync has finished for all repos"
    echo $'\E[37m'
}

function notifyrepos {
    pwd=${PWD}
    repos=(
        'custom'
        'delayedproc'
        'migration'
        'mobile'
        'mobilepayweb'
        'notifications'
        'opmgmt'
        'parkmonitor'
        'ppconfig'
        'rate'
        'rmc'
        'shared'
        'validation-old'
    )
    if (( $# != 0 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    echo "Starting Monitoring Repos: ${repos[@]}"
    echo $'\n'
    sleep 2
    for repo in "${repos[@]}"; do
        \cd ~/PP/Code/$repo &&
        branch="staging"
        if [[
            $repo == "ppconfig" ||
            $repo == "sandbox"
        ]]; then
            branch="master"
        elif [[
            $repo == "migration"
        ]]; then
            branch="development"
        fi
        if [[ $branch == "staging" ]]; then
            nohup git-notify staging &> /dev/null &
            nohup git-notify production &> /dev/null &
        else
            nohup git-notify $branch &> /dev/null &
        fi
    done
    echo $'\n\n\E[31m'
    message="Finished Start Notify For All Repos! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    \cd ${pwd}
}

function update_vbimage_dns {
    hostsfile="/etc/hosts"
    vbimagename="Ubuntu 14.04 LTS Server"
    sublist="http://easypparking.com/apps/ppconfig/devtools/getwhitelabelsubdomains.php"
    newip=`VBoxManage guestproperty get "$vbimagename" "/VirtualBox/GuestInfo/Net/0/V4/IP" | awk '{print $2}'`
    vbimagehostname=`nslookup $newip | \grep "name" | awk -F"= " '{print $2}' | tr -d '.'`
    \grep -v "#vbox-entry" $hostsfile > /tmp/hostfile.new
    echo "#begin #vbox-entry" >> /tmp/hostfile.new
    for sub in $(curl $sublist); do
        echo -e "$newip \t$sub.$vbimagehostname \t#vbox-entry" >> /tmp/hostfile.new
    done
    backupnum=$(expr `ls $hostsfile.backup* | wc -l | tr -d ' '` + 1)
    sudo cp $hostsfile $hostsfile.backup$backupnum
    sudo rm -f $hostsfile
    sudo mv /tmp/hostfile.new $hostsfile
}
