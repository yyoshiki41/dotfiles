### For golang ###
source "$HOME/.lan/go.util"
### For ruby ###
source "$HOME/.lan/ruby.util"

### nvm ###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm use --delete-prefix v4.2.4

# git extension for github
export PATH="$HOME/.git-hub:$PATH"
# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# For latex
#export PATH=/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:$PATH
