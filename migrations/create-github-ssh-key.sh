#!/usr/bin/env sh

# ASCII: http://patorjk.com/software/taag/#p=display&f=Graffiti&t=iMac%20Migration%20Script

github_ssh_key_directory=${1:-~/.ssh}
github_ssh_key_name=${2:-github_ed25519}
email_address=$3 # optional param - this will be prompted for if not provided

if [ $# -gt 0 ] && (($# < 2 || $# > 3)); then
  echo 'every required setting must be specified if not using the default values'
  exit 1
fi

function double_echo {
  echo && echo
}

bold=$(tput bold)
normal=$(tput sgr0)

function init {
  echo
  print_migration_header && double_echo
  print_purpose_header && double_echo
  confirm_continue && double_echo
  prompt_email_address && double_echo
  confirm_github_ssh_key_filename && double_echo
  generate_github_ssh_key && double_echo
  print_public_github_ssh_key && double_echo
  confirm_github_ssh_key_uploaded && double_echo
  add_github_ssh_key_to_agent && double_echo
  print_finished_header && double_echo
}

function print_migration_header {
  echo '.__   _____                     _____  .__                     __  .__                  _________            .__        __   '
  echo '|__| /     \ _____    ____     /     \ |__| ________________ _/  |_|__| ____   ____    /   _____/ ___________|__|______/  |_ '
  echo '|  |/  \ /  \\__  \ _/ ___\   /  \ /  \|  |/ ___\_  __ \__  \\   __\  |/  _ \ /    \   \_____  \_/ ___\_  __ \  \____ \   __\'
  echo '|  /    Y    \/ __ \\  \___  /    Y    \  / /_/  >  | \// __ \|  | |  (  <_> )   |  \  /        \  \___|  | \/  |  |_> >  |  '
  echo '|__\____|__  (____  /\___  > \____|__  /__\___  /|__|  (____  /__| |__|\____/|___|  / /_______  /\___  >__|  |__|   __/|__|  '
  echo '           \/     \/     \/          \/  /_____/            \/                    \/          \/     \/         |__|         '
}

function print_purpose_header {
  echo '_________                        __             ________.__  __  .__         ___.       _________ _________ ___ ___    ____  __.            '
  echo '\_   ___ \_______   ____ _____ _/  |_  ____    /  _____/|__|/  |_|  |__  __ _\_ |__    /   _____//   _____//   |   \  |    |/ _|____ ___.__.'
  echo '/    \  \/\_  __ \_/ __ \\__  \\   __\/ __ \  /   \  ___|  \   __\  |  \|  |  \ __ \   \_____  \ \_____  \/    ~    \ |      <_/ __ <   |  |'
  echo '\     \____|  | \/\  ___/ / __ \|  | \  ___/  \    \_\  \  ||  | |   Y  \  |  / \_\ \  /        \/        \    Y    / |    |  \  ___/\___  |'
  echo ' \______  /|__|    \___  >____  /__|  \___  >  \______  /__||__| |___|  /____/|___  / /_______  /_______  /\___|_  /  |____|__ \___  > ____|'
  echo '        \/             \/     \/          \/          \/              \/          \/          \/        \/       \/           \/   \/\/     '
}

function confirm_continue {
  echo '_________                _____.__                 _________                __  .__                      '
  echo '\_   ___ \  ____   _____/ ____\__|______  _____   \_   ___ \  ____   _____/  |_|__| ____  __ __   ____  '
  echo '/    \  \/ /  _ \ /    \   __\|  \_  __ \/     \  /    \  \/ /  _ \ /    \   __\  |/    \|  |  \_/ __ \ '
  echo '\     \___(  <_> )   |  \  |  |  ||  | \/  Y Y  \ \     \___(  <_> )   |  \  | |  |   |  \  |  /\  ___/ '
  echo ' \______  /\____/|___|  /__|  |__||__|  |__|_|  /  \______  /\____/|___|  /__| |__|___|  /____/  \___  >'
  echo '        \/            \/                      \/          \/            \/             \/            \/ '

  double_echo

  local CONTINUE_CONFIRM=''
  until [ "$CONTINUE_CONFIRM" = 'run' ]; do
    read -p 'type "run" to continue: ' CONTINUE_CONFIRM
  done
}

function prompt_email_address {
  echo '__________                               __    _________                                            ___________              .__.__   '
  echo '\______   \_______  ____   _____ _______/  |_  \_   ___ \  ____   _____ ___________    ____ ___.__. \_   _____/ _____ _____  |__|  |  '
  echo ' |     ___/\_  __ \/  _ \ /     \\____ \   __\ /    \  \/ /  _ \ /     \\____ \__  \  /    <   |  |  |    __)_ /     \\__  \ |  |  |  '
  echo ' |    |     |  | \(  <_> )  Y Y  \  |_> >  |   \     \___(  <_> )  Y Y  \  |_> > __ \|   |  \___  |  |        \  Y Y  \/ __ \|  |  |__'
  echo ' |____|     |__|   \____/|__|_|  /   __/|__|    \______  /\____/|__|_|  /   __(____  /___|  / ____| /_______  /__|_|  (____  /__|____/'
  echo '                               \/|__|                  \/             \/|__|       \/     \/\/              \/      \/     \/         '

  double_echo

  if [ -z $email_address ]; then
    until [[ $email_address =~ .+@.+ ]]; do
      read -p "what ${bold}email address${normal} do you want to ${bold}associate${normal} with this ${bold}ssh key${normal}? " email_address
    done
  else
    if [[ ! $email_address =~ .+@.+ ]]; then
      echo "the email address \"$email_address\" that you provided is ${bold}invalid${normal}"
      exit 2
    fi

    echo "are you sure you want to ${bold}associate${normal} this ssh key with the email address \"$email_address\"?"

    double_echo

    local EMAIL_ADDRESS_CONFIRM=''
    until [ "$EMAIL_ADDRESS_CONFIRM" = 'email' ]; do
      read -p 'type "email" to confirm: ' EMAIL_ADDRESS_CONFIRM
    done
  fi
}

function confirm_github_ssh_key_filename {
  echo '_________                _____.__                   _________ _________ ___ ___    ____  __.             ___________.__.__                                       '
  echo '\_   ___ \  ____   _____/ ____\__|______  _____    /   _____//   _____//   |   \  |    |/ _|____ ___.__. \_   _____/|__|  |   ____   ____ _____    _____   ____  '
  echo '/    \  \/ /  _ \ /    \   __\|  \_  __ \/     \   \_____  \ \_____  \/    ~    \ |      <_/ __ <   |  |  |    __)  |  |  | _/ __ \ /    \\__  \  /     \_/ __ \ '
  echo '\     \___(  <_> )   |  \  |  |  ||  | \/  Y Y  \  /        \/        \    Y    / |    |  \  ___/\___  |  |     \   |  |  |_\  ___/|   |  \/ __ \|  Y Y  \  ___/ '
  echo ' \______  /\____/|___|  /__|  |__||__|  |__|_|  / /_______  /_______  /\___|_  /  |____|__ \___  > ____|  \___  /   |__|____/\___  >___|  (____  /__|_|  /\___  >'
  echo '        \/            \/                      \/          \/        \/       \/           \/   \/\/           \/                 \/     \/     \/      \/     \/ '

  double_echo

  local SSH_KEY_DIRECTORY="${github_ssh_key_directory/#$HOME/~}"

  if [ ! -f $github_ssh_key_directory/$github_ssh_key_name ]; then
    echo "are you sure you want this ssh key ${bold}created${normal} at \"${bold}$SSH_KEY_DIRECTORY/$github_ssh_key_name${normal}\"?"
  else
    echo "the ssh key \"$github_ssh_key_name\" ${bold}already exists${normal}"
  fi


  double_echo

  local GITHUB_SSH_KEY_FILENAME_CONFIRM=''
  until [ "$GITHUB_SSH_KEY_FILENAME_CONFIRM" = 'filename' ]; do
    read -p 'type "filename" to confirm: ' GITHUB_SSH_KEY_FILENAME_CONFIRM
  done
}

function generate_github_ssh_key {
  echo '  ________                                   __  .__                   _________ _________ ___ ___    ____  __.            '
  echo ' /  _____/  ____   ____   ________________ _/  |_|__| ____    ____    /   _____//   _____//   |   \  |    |/ _|____ ___.__.'
  echo '/   \  ____/ __ \ /    \_/ __ \_  __ \__  \\   __\  |/    \  / ___\   \_____  \ \_____  \/    ~    \ |      <_/ __ <   |  |'
  echo '\    \_\  \  ___/|   |  \  ___/|  | \// __ \|  | |  |   |  \/ /_/  >  /        \/        \    Y    / |    |  \  ___/\___  |'
  echo ' \______  /\___  >___|  /\___  >__|  (____  /__| |__|___|  /\___  /  /_______  /_______  /\___|_  /  |____|__ \___  > ____|'
  echo '        \/     \/     \/     \/           \/             \//_____/           \/        \/       \/           \/   \/\/     '

  double_echo

  mkdir -p $github_ssh_key_directory

  if [ ! -f $github_ssh_key_directory/$github_ssh_key_name ]; then
    ssh-keygen -t ed25519 -C $email_address -N '' -f $github_ssh_key_directory/$github_ssh_key_name
  else
    echo "the ssh key \"$github_ssh_key_name\" ${bold}already exists${normal}"
  fi
}

function print_public_github_ssh_key {
  echo '__________     ___.   .__  .__           _________ _________ ___ ___    ____  __.            '
  echo '\______   \__ _\_ |__ |  | |__| ____    /   _____//   _____//   |   \  |    |/ _|____ ___.__.'
  echo ' |     ___/  |  \ __ \|  | |  |/ ___\   \_____  \ \_____  \/    ~    \ |      <_/ __ <   |  |'
  echo ' |    |   |  |  / \_\ \  |_|  \  \___   /        \/        \    Y    / |    |  \  ___/\___  |'
  echo ' |____|   |____/|___  /____/__|\___  > /_______  /_______  /\___|_  /  |____|__ \___  > ____|'
  echo '                    \/             \/          \/        \/       \/           \/   \/\/     '

  double_echo

  if [ ! -f $github_ssh_key_directory/$github_ssh_key_name.pub ]; then
    ssh-keygen -y -f $github_ssh_key_directory/$github_ssh_key_name > $github_ssh_key_directory/$github_ssh_key_name.pub
  fi

  cat $github_ssh_key_directory/$github_ssh_key_name.pub
}

function confirm_github_ssh_key_uploaded {
  echo '_________                _____.__                   ________.__  __  .__         ___.       _________ _________ ___ ___  '
  echo '\_   ___ \  ____   _____/ ____\__|______  _____    /  _____/|__|/  |_|  |__  __ _\_ |__    /   _____//   _____//   |   \ '
  echo '/    \  \/ /  _ \ /    \   __\|  \_  __ \/     \  /   \  ___|  \   __\  |  \|  |  \ __ \   \_____  \ \_____  \/    ~    \'
  echo '\     \___(  <_> )   |  \  |  |  ||  | \/  Y Y  \ \    \_\  \  ||  | |   Y  \  |  / \_\ \  /        \/        \    Y    /'
  echo ' \______  /\____/|___|  /__|  |__||__|  |__|_|  /  \______  /__||__| |___|  /____/|___  / /_______  /_______  /\___|_  / '
  echo '        \/            \/                      \/          \/              \/          \/          \/        \/       \/  '

  double_echo

  echo "above is your ${bold}public${normal} ssh key and it has already been ${bold}copied${normal} to your clipboard"
  echo "you must now go to https://github.com/settings/keys to ${bold}add it to your profile${normal}"
  echo "you can also ${bold}navigate directly${normal} to the add a new ssh key page https://github.com/settings/ssh/new"

  double_echo

  computer_name=$(system_profiler SPSoftwareDataType | awk 'match($0, /Computer Name: /) { print substr($0, RSTART + RLENGTH) }')

  echo "enter \"$computer_name\" in the \"Title\" field"
  echo "paste your ${bold}public${normal} ssh key in the \"Key\" field"
  echo 'click the green "Add SSH key" button'

  double_echo

  pbcopy < $github_ssh_key_directory/$github_ssh_key_name.pub

  local GITHUB_SSH_KEY_UPLOADED_CONFIRM=''
  until [ "$GITHUB_SSH_KEY_UPLOADED_CONFIRM" = 'github' ]; do
    read -p 'type "github" to acknowledge: ' GITHUB_SSH_KEY_UPLOADED_CONFIRM
  done
}

function add_github_ssh_key_to_agent {
  echo '  _________ _________ ___ ___            ____  __.                _____                         __   '
  echo ' /   _____//   _____//   |   \          |    |/ _|____ ___.__.   /  _  \    ____   ____   _____/  |_ '
  echo ' \_____  \ \_____  \/    ~    \  ______ |      <_/ __ <   |  |  /  /_\  \  / ___\_/ __ \ /    \   __\'
  echo ' /        \/        \    Y    / /_____/ |    |  \  ___/\___  | /    |    \/ /_/  >  ___/|   |  \  |  '
  echo '/_______  /_______  /\___|_  /          |____|__ \___  > ____| \____|__  /\___  / \___  >___|  /__|  '
  echo '        \/        \/       \/                   \/   \/\/              \//_____/      \/     \/      '

  double_echo

  ssh-add $github_ssh_key_directory/$github_ssh_key_name
}

function print_finished_header {
  echo '___________.__       .__       .__               .___'
  echo '\_   _____/|__| ____ |__| _____|  |__   ____   __| _/'
  echo ' |    __)  |  |/    \|  |/  ___/  |  \_/ __ \ / __ | '
  echo ' |     \   |  |   |  \  |\___ \|   Y  \  ___// /_/ | '
  echo ' \___  /   |__|___|  /__/____  >___|  /\___  >____ | '
  echo '     \/            \/        \/     \/     \/     \/ '
}

init
