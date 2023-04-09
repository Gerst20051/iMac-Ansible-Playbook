# PassportParking Misc Utility Functions

function mergediff {
    git checkout production
    git merge --no-commit --no-ff $1
    git diff --cached > ~/mergepreview.diff
    git reset --hard origin/production
}

# Find Production Operator Settings Matching Key ($1 = operator_id, $2 = substring of key)
function find_setting_keys {
    curl -sX 'GET' "https://ppprk.com/apps/v7/mobile/api/index.php/getoperatorsettings?operatorid=$1&whitelabel_operator_id=$1&apikey=$PASSPORT_APIKEY&country_iso_code=US" \
        | jq ".data | with_entries(select(.key | contains(\"$2\")))"
}

# Find Production Operator Settings Matching Value ($1 = operator_id, $2 = substring of value)
function find_setting_values {
    curl -sX 'GET' "https://ppprk.com/apps/v7/mobile/api/index.php/getoperatorsettings?operatorid=$1&whitelabel_operator_id=$1&apikey=$PASSPORT_APIKEY&country_iso_code=US" \
        | jq "[ .data | to_entries[] ] | map(select(.value != null) | select(.key != \"opsman_password_rules\") | select(.key != \"profileSettings\") | select(.value | contains(\"$2\"))) | from_entries"
}

# Find Production Strings Matching Key ($1 = operator_id, $2 = substring of key)
function find_string_keys {
    curl -sX 'GET' "https://ppprk.com/apps/v7/mobile/api/index.php/getstrings?operatorId=$1&apikey=$PASSPORT_APIKEY&locale=en_US&system=mobile" \
        | jq ".data | with_entries(select(.key | contains(\"$2\")))"
}

# Find Production Strings Matching Value ($1 = operator_id, $2 = substring of value)
function find_string_values {
    curl -sX 'GET' "https://ppprk.com/apps/v7/mobile/api/index.php/getstrings?operatorId=$1&apikey=$PASSPORT_APIKEY&locale=en_US&system=mobile" \
        | jq ".data | with_entries(select(.value | strings // \"\" | contains(\"$2\")))"
}

# Copy Commit Messages From All Repos
function copyrepologmessages {
    excludes=1
    showfreq=1
    pwd=${PWD}
    repos=(
        'build'
        'centralpay'
        'centralpaydevice'
        'chef'
        'custom'
        'db'
        'delayedproc'
        'delayedproc1'
        'initscripts'
        'kegerator'
        'migration'
        'migration-utility'
        'mobile'
        'mobileapp'
        'mobilepayweb'
        'mobilepaywin'
        'notifications'
        'operator'
        'opmgmt'
        'parker'
        'parkerv2'
        'parkmonitor'
        'passportwebsite'
        'paymentgateway'
        'ppconfig'
        'ppfs'
        'ppinternal'
        'produpdate'
        'rate'
        'rmc'
        'reservations'
        'sandbox'
        'shared'
        'strings'
        'test'
        'testing'
        'tlotest'
        'utils'
        'validation'
        'validation-old'
        'violations'
        'ppmobilepay'
        'superpassport'
        'passportapp'
        'parkenforcer'
        'rmcclient'
        'validationclient'
        'iosmobilepay-swift'
    )
    if (( $# != 0 )); then
        repos=("$@")
    fi
    echo $'\n\E[35m'
    > ~/PP/commitsautolist.txt
    echo "Copying All Repo Log Messages: ${repos[@]}"
    for repo in "${repos[@]}"; do
        echo $'\n\E[31m'
        message="Copying Repo '"
        message+=$'\E[36m'
        message+=$repo
        message+=$'\E[31m'
        message+="' Log Messages"
        message+=$'\E[37m'
        echo $message
        path="Code"
        if [[
            $repo == "initscripts" ||
            $repo == "kegerator" ||
            $repo == "produpdate" ||
            $repo == "reservations" ||
            $repo == "test" ||
            $repo == "tlotest"
        ]]; then
            path+="/frozen"
        fi
        if [[
            $repo == "centralpay" ||
            $repo == "centralpaydevice" ||
            $repo == "db" ||
            $repo == "delayedproc1" ||
            $repo == "mobileapp" ||
            $repo == "operator" ||
            $repo == "parker" ||
            $repo == "parkerv2" ||
            $repo == "passportwebsite" ||
            $repo == "paymentgateway" ||
            $repo == "ppfs" ||
            $repo == "ppinternal" ||
            $repo == "strings"
        ]]; then
            path+="/timemachine"
        fi
        if [[ $repo == "ppmobilepay" ]]; then
            path="Titanium/PPMobilePayWorkspace"
        fi
        if [[ $repo == "superpassport" ]]; then
            path="Eclipse/SuperPassportWorkspace"
        fi
        if [[ $repo == "passportapp" ]]; then
            path="Android/PassportAppWorkspace"
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
        if [[ $repo == "iosmobilepay-swift" ]]; then
            path="Swift/IOSMobilePaySwiftWorkspace"
        fi
        if [[ $repo == "bluetoothle" ]]; then
            path="Android/BluetoothLEWorkspace"
        fi
        \cd ~/PP/$path/$repo &&
            git --no-pager log --oneline | cut -d " " -f2- | awk '{print tolower($0)}'| LC_ALL=C sort -f >> ~/PP/commitsautolist.txt
    done
    if (( $excludes == 1 )); then
        \grep -Ev "merge branch" ~/PP/commitsautolist.txt > ~/PP/commitsautolist2.txt
        \mv ~/PP/commitsautolist2.txt ~/PP/commitsautolist.txt
    fi
    if (( $showfreq == 1 )); then
        cat ~/PP/commitsautolist.txt | LC_ALL=C sort -f | LC_ALL=C uniq -c | LC_ALL=C sort -rf > ~/PP/commitsauto.txt
    else
        cat ~/PP/commitsautolist.txt | LC_ALL=C sort -f | LC_ALL=C uniq > ~/PP/commitsauto.txt
    fi
    echo $'\n\n\E[31m'
    message="Finished Copying All Repo Log Messages! Current Directory: "
    message+=$'\E[33m'
    message+="${pwd}"
    message+=$'\E[37m'
    echo $message && echo $'\n' &&
    cd ${pwd}
}
