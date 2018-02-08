export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# Added by Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# The next line updates PATH for the Google Cloud SDK.
source "/usr/local/google-cloud-sdk/path.zsh.inc"
# The next line enables shell command completion for gcloud.
source "/usr/local/google-cloud-sdk/completion.zsh.inc"
export PATH="/usr/local/google-cloud-sdk/bin:$PATH"

# Added by travis gem
if [ -f "$HOME/.travis/travis.sh" ]; then
  source "$HOME/.travis/travis.sh"
fi

# For PostgreSQL
#export PGDATA=/usr/local/var/postgres

# Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

# Go App Engine SDK
#export PATH="/usr/local/go_appengine:$PATH"

# For latex
#export PATH=/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:$PATH


# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# NOTE:
# By default sdkman sets `alias gvm="sdk"` for backwards compatibility,
# so I set `sdkman_disable_gvm_alias=true` in `${SDKMAN_DIR}/etc/config` and disable this.
export SDKMAN_DIR="$HOME/.sdkman"
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
