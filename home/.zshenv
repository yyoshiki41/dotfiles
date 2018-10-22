export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# yarn
export PATH="$(yarn global bin):$PATH"

# mysql 5.7
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Added by travis gem
if [ -f "$HOME/.travis/travis.sh" ]; then
  source "$HOME/.travis/travis.sh"
fi

# The next line updates PATH for the Google Cloud SDK.
source "/usr/local/google-cloud-sdk/path.zsh.inc"
# The next line enables shell command completion for gcloud.
source "/usr/local/google-cloud-sdk/completion.zsh.inc"
export PATH="/usr/local/google-cloud-sdk/bin:$PATH"

# Added by Android SDK
#export ANDROID_HOME=$HOME/Library/Android/sdk
#export PATH="$ANDROID_HOME/platform-tools:$PATH"

# For PostgreSQL
#export PGDATA=/usr/local/var/postgres

# Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

# Go App Engine SDK
#export PATH="/usr/local/go_appengine:$PATH"

# For latex
#export PATH=/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:$PATH
