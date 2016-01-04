### For golang ###
source "$HOME/.lan/go.util"
### For ruby ###
source "$HOME/.lan/ruby.util"

### nvm ###
if [ -e "$(brew --prefix nvm)/nvm.sh" ]; then
  source $(brew --prefix nvm)/nvm.sh
  nvm alias stable v0.10.33
  nvm use stable
fi

# git extension for github
export PATH="$HOME/.git-hub:$PATH"
# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
# For latex
#export PATH=/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:$PATH
