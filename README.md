# iMac-Ansible-Playbook

An ansible playbook used to maintain an iMac

# Manual Steps Before Provision

- Add Github SSH Key To `~/.ssh/github_rsa`
- Add SSH Key To SSH Auth Agent `ssh-add ~/.ssh/github_rsa`
- Clone `iMac-Ansible-Playbook` Repo From Gitlab
 ** [$]> `git clone git@github.com:Gerst20051/iMac-Ansible-Playbook.git ~/iMac-Ansible-Playbook`
- Setup `iMac-Ansible-Playbook` Repo
 * Copy Vars File `cp vars.template.yml vars.private.yml`
 * Fill In The Missing Variables (`var1`, `var2`)
- Install Homebrew
 * https://brew.sh/
 * [$]> `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
 * The `Xcode Command Line Tools` will be installed.
- Install Ansible
 * [$]> `brew install ansible`

# Run Ansible Playbook

[$]> `ansible-playbook -v ~/iMac-Ansible-Playbook/playbook.yml -i ~/iMac-Ansible-Playbook/inventory --ask-become-pass`

# Known Issues

TASK [Gathering Facts] **************************************************************************************************************************************************************
[WARNING]: Platform darwin on host 0.0.0.0 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change this.
See https://docs.ansible.com/ansible/2.9/reference_appendices/interpreter_discovery.html for more information.
