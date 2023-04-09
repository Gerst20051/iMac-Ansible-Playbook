# iMac-Ansible-Playbook

An ansible playbook used to maintain an iMac

# Manual Steps Before Provision

- Add GitHub SSH Key To `~/.ssh/github_ed25519`
- Add SSH Key To SSH Auth Agent `ssh-add ~/.ssh/github_ed25519`
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

# Todo List

1. Set ZSH As Default Shell
1. Setup Python
1. Save System Config Output
1. Setup ~/.npmrcs
1. Remove Atom
1. SSH Config

# Known Issues
