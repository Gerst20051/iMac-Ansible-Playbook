# PassportParking SSH Aliases

function ssh_prod_fslog {
    ssh utility "tailf /var/log/mobile/production.log | grep '$1'"
}

function ssh_stag_fslog {
    ssh utility "tailf /var/log/mobile/staging.log | grep '$1'"
}

function ssh_prod_fshlog {
    ssh utility "cat /var/log/mobile/production.log | grep '$1'"
}

function ssh_stag_fshlog {
    ssh utility "cat /var/log/mobile/staging.log | grep '$1'"
}

function ssh_prod_fshlogg {
    ssh utility "tac /var/log/mobile/production.log | grep '$1'"
}

function ssh_stag_fshlogg {
    ssh utility "tac /var/log/mobile/staging.log | grep '$1'"
}

function ssh_prod_fshzlog {
    ssh utility "find /var/log/mobile/ -iname 'production.log*gz' 2>/dev/null | sort -r | xargs zgrep --color=always '$1'"
}

function ssh_stag_fshzlog {
    ssh utility "find /var/log/mobile/ -iname 'staging.log*gz' 2>/dev/null | sort -r | xargs zgrep --color=always '$1'"
}
