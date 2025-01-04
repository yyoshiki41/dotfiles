### Go ###
source "$HOME/.lan/go.util"

source "$HOME/.lan/ruby.util"

# Control system resources
ulimit -u 1024
ulimit -n 16384

eval "$(/opt/homebrew/bin/brew shellenv)"
