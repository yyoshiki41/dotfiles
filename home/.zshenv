export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
# For PostgreSQL
export PGDATA=/usr/local/var/postgres

# The next line updates PATH for the Google Cloud SDK.
source '/usr/local/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
source '/usr/local/google-cloud-sdk/completion.zsh.inc'
export PATH="/usr/local/google-cloud-sdk/bin:$PATH"

# Added by travis gem
if [ -f "$HOME/.travis/travis.sh" ]; then
  source /Users/yyoshiki41/.travis/travis.sh
fi

# git extension for github
#export PATH="$HOME/.git-hub:$PATH"

# Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

# Go App Engine SDK
#export PATH="/usr/local/go_appengine:$PATH"

# For latex
#export PATH=/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:$PATH
