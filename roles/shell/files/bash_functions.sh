# Collection of Bash Functions

# Display List Of Files With Given Extension
function lsext {
    find . -type f -iname '*.'${1}'' -exec ls -l {} \; ;
}

# Execute A Given Command On A Group Of Files With A Given Extension
function batchexec {
    find . -type f -iname '*.'${1}'' -exec ${@:2}  {} \; ;
}

# Generate A Random Password Of Given Length
function rpass {
    cat /dev/urandom | tr -cd '[:graph:]' | head -c ${1:-12}
}

# Display IP Address Of Given Interface
function getip {
    /sbin/ifconfig ${1:-eth0} | awk '/inet addr/ {print $2}' | awk -F: '{print $2}';
}
