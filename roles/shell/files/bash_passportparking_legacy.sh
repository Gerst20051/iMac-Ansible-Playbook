# PassportParking Legacy

# Sync Stag and Prod Branches With Remote Branches
function syncbranches {
    git fetch
    #echo $'\n'
    #git checkout staging &&
    #git pull origin staging
    echo $'\n'
    git checkout production &&
    git pull origin production
}

# Sync Staging Branch With Remote Branch
function syncstagbranch {
    git fetch
    echo $'\n'
    git checkout staging &&
    git pull origin staging
}

# Sync Production Branch With Remote Branch
function syncprodbranch {
    git fetch
    echo $'\n'
    git checkout production &&
    git pull origin production
}

# Sync Master Branch With Remote Branch
function syncmasterbranch {
    git fetch
    echo $'\n'
    git checkout master &&
    git pull origin master
}

# Sync Development Branch With Remote Branch
function syncdevbranch {
    git fetch
    echo $'\n'
    git checkout development &&
    git pull origin development
}

# Sync Develop Branch With Remote Branch
function syncdevelopbranch {
    git fetch
    echo $'\n'
    git checkout develop &&
    git pull origin develop
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
        'rate'
        'shared'
        'validation-old'
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
        # \cd ~/PP/Code/$repo &&
        \cd ~/Web/PP/Code/$repo &&
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

# Sync Stag and Prod Branches OR Master Branch For All Repos
function syncrepos {
    pwd=${PWD}
    remote="origin"
    repos=(
        'api'
        'custom'
        'database'
        'delayedproc'
        'eligibilitysystem'
        'migration'
        'mobile'
        'mobilepayweb'
        'notifications'
        'opmgmt'
        'parkmonitor'
        'passportmailer'
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
            $repo == "database" ||
            $repo == "delayedproc" ||
            $repo == "passportmailer" ||
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
        # \cd ~/PP/Code/$repo &&
        \cd ~/Web/PP/Code/$repo &&
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

# Sync Stag and Prod Branches, Master, OR Dev Branch For All Project Repos
function syncprojectrepos {
    pwd=${PWD}
    remote="origin"
    repos=(
        'iosmobilepay-swift'
        'ppmobilepay'
        'superpassport'
        'androidmobilepay'
        'parkenforcer'
        'rmcclient'
        'validationclient'
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
        if [[ $repo == "ppmobilepay" ]]; then
            path="Titanium/PPMobilePayWorkspace"
        fi
        if [[ $repo == "iosmobilepay-swift" ]]; then
            path="Swift/IOSMobilePaySwiftWorkspace"
            function="syncdevelopbranch"
        fi
        if [[ $repo == "superpassport" ]]; then
            path="Eclipse/SuperPassportWorkspace"
        fi
        if [[ $repo == "androidmobilepay" ]]; then
            path="Android/AndroidMobilePayWorkspace"
        fi
        if [[ $repo == "parkenforcer" ]]; then
            path="Android/ParkEnforcerWorkspace"
        fi
        if [[ $repo == "rmcclient" ]]; then
            path="Eclipse/RMCClientWorkspace"
        fi
        if [[ $repo == "validationclient" ]]; then
            path="Eclipse/ValidationClientWorkspace"
        fi
        \cd ~/Web/PP/$path/$repo &&
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

# Checkout A Branch On All Repos
function checkout_branches {
    pwd=${PWD}
    path="PP/Code"
    remote="origin"
    branch="production"
    repos=(
        'custom'
        'delayedproc'
        'mobile'
        'mobilepayweb'
        'notifications'
        'opmgmt'
        'parkmonitor'
        'rate'
        'rmc'
        'shared'
        'validation-old'
    )
    if (( $# == 1 )); then
        branch=$1
    elif (( $# > 1 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    echo "Syncing Branch '$branch' For Repos: ${repos[@]}"
    sleep 2
    for repo in "${repos[@]}"; do
        echo $'\n\E[31m'
        message="Syncing Branch For Repo '"
        message+=$'\E[36m'
        message+=$repo
        message+=$'\E[31m'
        message+="'"
        message+=$'\E[37m'
        echo $message
        \cd ~/$path/$repo &&
            git add -A &&
            git stash &&
            git fetch --all &&
            git checkout $branch &&
            git reset --hard $remote/$branch
            sleep 1
    done
    echo $'\n\n\E[31m'
    message="Finished Syncing Branch '$remote/$branch' For All Repos! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    cd ${pwd}
}
