# Collection Of Custom Bash Functions

# perform 'ls' after 'cd' if successful
cdls() {
    builtin cd "$*"
    RESULT=$?
    if [ "$RESULT" -eq 0 ]; then
        \ls -GFalh
    fi
}

alias cd='cdls'

function regex { gawk ''; }

# go back x directories
b(){
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# make and cd into a directory
function mcd(){
    mkdir -p "$1" && cd "$1";
}

# return line numbers of file
lines(){
    str=""
    IFS=','
    read -a array <<< "$1"
    for element in "${array[@]}"
    do
        str=$str"$element"
    done
    sed -n "$str" "$2"
    unset IFS
}

function glines {
    sed -n "$1" "$2"
}

function esc {
    local escaped="'\''"
    echo "${1//\'/$escaped}"
}

function myesc {
    local escaped="\'"
    echo "${1//\'/$escaped}"
}

# email using unc cs mailx
function emailtofunc {
    local message=""
    local file=$3
    if [[ -a "$file" ]]; then
        message="`cat $file`"
        echo "File Sent: $file"
        echo "$message"
        scp $file unc":~/email/tmp.txt"
        unc "emailto '$1' '$2' '$message' 'file'"
    else
        message="$3"
        echo "Message Sent: $message"
        unc "emailto '$1' '$2' '$message'"
    fi
}
alias emailto='emailtofunc'

function httpdcount {
    ps aux | grep httpd | grep -v grep | wc -l | xargs
}

# Show Hidden Files
function showhiddenfiles {
    defaults write com.apple.finder AppleShowAllFiles -bool yes
    killall Finder
}

# Hide Hidden Files
function hidehiddenfiles {
    defaults write com.apple.finder AppleShowAllFiles -bool no
    killall Finder
}

# Grep Bash Files for Phrase
function fbash {
    find ~ -maxdepth 1 -type f -name ".bash*" ! -name "*.bash_history" -exec grep -H "$1" {} \;
}

# Git Rebase To Commit Hash
function git_rebase_commit_hash {
    echo $'\n\nDo You Want To Use Interactive Mode?'
    INTERACTIVE_MODE=''
    until [ ! -z $INTERACTIVE_MODE ]; do
        echo -n $'\n\nEnter One Of The Following Options (YES/Yes/yes Y/y 1) or (NO/No/no N/n 0): '
        read IMI
        if [ ! -z "$IMI" ]; then
            if [ "$IMI" = 'YES' ] || [ "$IMI" = 'Yes' ] || [ "$IMI" = 'yes' ] || [ "$IMI" = 'Y' ] || [ "$IMI" = 'y' ] || [ "$IMI" = '1' ]; then
                INTERACTIVE_MODE=1
            elif [ "$IMI" = 'NO' ] || [ "$IMI" = 'No' ] || [ "$IMI" = 'no' ] || [ "$IMI" = 'N' ] || [ "$IMI" = 'n' ] || [ "$IMI" = '0' ]; then
                INTERACTIVE_MODE=0
            fi
        fi
    done
    echo $'\n\nWhich Commit Hash Would You Like To Rebase To?\n\n'
    git log --oneline -30
    echo -n $'\n\nEnter Commit Hash: '
    read COMMIT_HASH
    until [ ! -z $COMMIT_HASH ]; do
        echo -n $'\n\nEnter A Valid Commit Hash: '
        read COMMIT_HASH
    done
    echo $'\n'
    git merge-base --is-ancestor HEAD $COMMIT_HASH
    exit_status=$?
    if [ $exit_status -eq 1 ]; then
        count=$(git rev-list $COMMIT_HASH..HEAD --count)
        # count 0 should be impossible since it's handled above with is-ancestor
        if [ $count -eq 0 ]; then
            echo "Can't Rebase To HEAD"
        else
            if [ $INTERACTIVE_MODE -eq 1 ]; then
                count=$((count + 1))
                git rebase -i HEAD~$count
            elif [ $INTERACTIVE_MODE -eq 0 ]; then
                git reset HEAD~$count && git add -A && git commit --amend --no-verify
            fi
            echo -n $'\n'
        fi
    elif [ $exit_status -eq 0 ]; then
        echo "The Commit '$COMMIT_HASH' Isn't An Ancestor Of HEAD" $'\n'
    else
        echo -n $'\n'
    fi
}

function git_status_directory {
    dir="$1"
    if [ -z "$dir" ]; then # No directory has been provided, use current
        dir="`pwd`"
    fi
    if [[ $dir != */ ]]; then # Make sure directory ends with '/'
        dir="$dir/*"
    else
        dir="$dir*"
    fi
    echo
    for f in $dir; do # Loop through all sub-directories
        [ -d "${f}" ] || continue # Skip anything not a directory
        echo -en "\033[0;35m"
        echo "${f}"
        echo -en "\033[0m"
        if [ -d "$f/.git" ]; then # Check if directory is a git repository
            modified=0
            \cd $f
            if [ $(git status | grep modified -c) -ne 0 ]; then # Check for modified files
                modified=1
                echo -en "\033[0;31m"
                echo 'Modified files'
                echo -en "\033[0m"
            fi
            if [ $(git status | grep Untracked -c) -ne 0 ]; then # Check for untracked files
                modified=1
                echo -en "\033[0;31m"
                echo 'Untracked files'
                echo -en "\033[0m"
            fi
            if [ $modified -eq 0 ]; then # Check if nothing to commit
                echo 'Nothing to commit'
            else
                git status
            fi
            \cd ../
        else
            echo 'Not a git repository'
        fi
        echo
    done
}

function directory_to_titlebar {
    local pwd_length=42  # The maximum length we want (seems to fit nicely
                         # in a default length Terminal title bar).

    # Get the current working directory. We'll format it in $dir.
    local dir="$PWD"

    # Substitute a leading path that's in $HOME for "~"
    if [[ "$HOME" == ${dir:0:${#HOME}} ]]; then
        dir="~${dir:${#HOME}}"
    fi

    # Append a trailing slash if it's not there already.
    if [[ ${dir:${#dir}-1} != "/" ]]; then
        dir="$dir/"
    fi

    # Truncate if we're too long.
    # We preserve the leading '/' or '~/', and substitute
    # ellipses for some directories in the middle.
    if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]]; then
        local tilde=${BASH_REMATCH[1]}
        local directory=${BASH_REMATCH[2]}

        # At this point, $directory is the truncated end-section of the
        # path. We will now make it only contain full directory names
        # (e.g. "Library/Mail" -> "/Mail").
        if [[ "$directory" =~ [^/]*(.*) ]]; then
            directory=${BASH_REMATCH[1]}
        fi

        # Can't work out if it's possible to use the Unicode ellipsis,
        # '…' (Unicode 2026). Directly embedding it in the string does not
        # seem to work, and \u escape sequences ('\u2026') are not expanded.
        #printf -v dir "$tilde/\u2026$s", $directory"
        dir="$tilde/...$directory"
    fi

    # Don't embed $dir directly in printf's first argument, because it's
    # possible it could contain printf escape sequences.
    printf "\033]0;%s\007" "$dir"
}

if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" ]]; then
    export PROMPT_COMMAND="directory_to_titlebar"
fi
