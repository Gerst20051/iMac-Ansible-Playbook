# Collection Of Bash Prompts

# Change prompt
export PS1="\n\[\e[0;36m\]┌─[\[\e[0m\]\[\e[1;33m\]\u\[\e[0m\]\[\e[1;36m\] @ \[\e[0m\]\[\e[1;33m\]\h\[\e[0m\]\[\e[0;36m\]]─[\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;36m\]]\[\e[0;36m\]─[\[\e[0m\]\[\e[0;31m\]\!\[\e[0m\]\[\e[0;36m\]]\[\e[0m\]\n\[\e[0;36m\]└─[\[\e[0m\]\[\e[1;37m\]\$\[\e[0m\]\[\e[0;36m\]]› \[\e[0m\]"

function parse_git_dirty {
    [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
#export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

function prompt {
    # set prompt to mac default
    export PS1="\h:\W \u\$ "
    export PS2="> "
    export PS3=""
    export PS4="+ "
}

function prompt1 {
    local BLUE="\[\033[0;34m\]"
    local DARK_BLUE="\[\033[1;34m\]"
    local RED="\[\033[0;31m\]"
    local DARK_RED="\[\033[1;31m\]"
    local NO_COLOR="\[\033[0m\]"
    case $TERM in
        xterm*|rxvt*)
            TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            ;;
        *)
            TITLEBAR=""
            ;;
    esac
    PS1="\u@\h [\t]> "
    PS1="${TITLEBAR}\
    $BLUE\u@\h $RED[\t]>$NO_COLOR "
    PS2='continue-> '
    PS4='$0.$LINENO+ '
}

function prompt2 {
    __cwd3(){
        typeset start=${PWD/${HOME}/\~}
        typeset delete=${start%/*/*/*}
        typeset partial=${start#${delete}/}
        if [[ "${partial}" != /* && "${partial}" != \~* ]]
        then
            partial="/.../${partial}"
        fi
        echo "${partial}"
    }
    PS1="\![\h]\$(__cwd3)> "
}

function prompt3 {
    export PS1='\u@\h [`httpdcount`]> '
}

function prompt4 {
    export PS1='\u@\h \w> '
}

function prompt5 {
    export PS1='\d \h $ '
}

function prompt6 {
    export PS1='[\d \t \u@\h:\w ] $ '
}

function prompt7 {
    # If id command returns zero, you’ve root access.
    if [ $(id -u) -eq 0 ];
    then # you are root, set red color prompt
        PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
    else # normal
        PS1="[\\u@\\h:\\w] $"
    fi
}

function prompt8 {
    PS1="\n\[\e[0;36m\]┌─[\[\e[0m\]\[\e[1;33m\]\u\[\e[0m\]\[\e[1;36m\] @ \[\e[0m\]\[\e[1;33m\]\h\[\e[0m\]\[\e[0;36m\]]─[\[\e[0m\]\[\e[1;34m\]\w\[\e[0m\]\[\e[0;36m\]]\[\e[0;36m\]─[\[\e[0m\]\[\e[0;31m\]\!\[\e[0m\]\[\e[0;36m\]]\[\e[0m\]\n\[\e[0;36m\]└─[\[\e[0m\]\[\e[1;37m\]\$\[\e[0m\]\[\e[0;36m\]]› \[\e[0m\]"
}

function prompt9 {
    export PS1="\e[01;33m# \e[01;35m\D{%A %e %B %G %R %Z} \e[00;31m\u\e[01;32m@\e[00;31m\h \e[01;33m\w :\e[00m\n"
}

function prompt10 {
    PS1='${PWD/????????????????????????????*/...${PWD:${#PWD}-25}} \e7\e[1;1H\w\e[K\e8'
}

function prompt11 {
    PS1='${PWD/????????????????????????????*/...${PWD:${#PWD}-25}} \e7\e[$LINES;1H\w\e[K\e8'
}

function prompt12 {
    PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
}

function prompt13 {
    if [ $(id -u) -eq 0 ];
    then # you are root
        PS1="$PWD #"
    else # normal
        PS1="$PWD $"
    fi
}
