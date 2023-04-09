export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -f ~/.nvm/nvm.sh && . $_
test -f $NVM_DIR/bash_completion && . $_
test -f ~/.bash_exports && . $_
test -f ~/.bash_prompts && . $_
test -f ~/.bash_functions && . $_
test -f ~/.bash_customfunctions && . $_
test -f ~/.bash_aliases && . $_
test -f ~/.bash_passportparking_legacy && . $_
test -f ~/.bash_passportparking_main && . $_
test -f ~/.bash_passportparking_misc && . $_
test -f ~/.bash_passportparking_modern && . $_
test -f ~/.bash_passportparking_ssh && . $_
