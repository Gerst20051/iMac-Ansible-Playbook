# collection of zsh aliases

# run ansible playbook to provision local macos machine
alias provision='ansible-playbook -v ~/iMac-Ansible-Playbook/playbook.yml -i ~/iMac-Ansible-Playbook/inventory --ask-become-pass'
