# language
export LANG=ja_JP.UTF-8
# '#' 以降をコメントとして扱う
setopt interactive_comments
# beep音を鳴らさない
setopt no_beep
# 出力時8ビットを通す
setopt print_eight_bit
# フローコントロールを無効にする
setopt no_flow_control
# スペルチェック
setopt correct
# emacs 風キーバインドにする
bindkey -e
# colors
autoload -U colors && colors
# zsh hooks
autoload -Uz add-zsh-hook

### prompt ###
# vcs_info
autoload -Uz vcs_info
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%}"
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
function precmd () {
    vcs_info
}
# [git status][current directory]
RPROMPT='${vcs_info_msg_0_}'$RPROMPT
ps_exit="\\(^o^)/"
function precmd_01() {
    if [ "$?" -ne 0 ]; then
        ps_exit="/(T_T)\\"
    else
        ps_exit="\\(^o^)/"
    fi
}
add-zsh-hook precmd precmd_01
PROMPT='[%F{green}%T %F{yellow}%c ${ps_exit}%f]$ '

# List direcory contents
export LSCOLORS=cxfxgxdxbxeghdabagacad
export LS_COLORS='di=32:ln=35:so=36:pi=33:ex=31:bd=34;46:cd=37;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' list-colors 'di=32' 'ln=35' 'so=36' 'ex=31' 'bd=34;46' 'cd=37;43'

### zsh-completions ###
if [ -f "${HOME}/.zsh/completions" ]; then
    fpath=(~/.zsh/completions $fpath)
fi
if [ -f "/usr/local/share/zsh-completions" ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# enable zsh completion
autoload -Uz compinit
compinit -u
# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

### zsh_history ###
HISTFILE=$HOME/.zsh_history
HISTSIZE=1048576
SAVEHIST=1048576
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
# The format of history is below
# ": <beginning time>:<elapsed seconds>;<command>"
setopt extended_history
# 補完時にhistoryを展開する
setopt hist_expand

# 自動でリストアップ
setopt auto_list
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# Directory stack
# $ cd -num
DIRSTACKSIZE=10
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
# Call ls command every time the current directory is changed
function chpwd() { ls -G }

# z
. "/usr/local/opt/z/etc/profile.d/z.sh"
# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'
# less
alias l='less'
export LESS='-I -R -M -W'
export LESSOPEN="| /usr/local/opt/source-highlight/bin/src-hilite-lesspipe.sh %s"

### Alias ###
# global alias
alias -g F='| fx'
alias -g G='| ag'
alias -g H='| head'
alias -g J='| jq .'
alias -g L='| less'
alias -g P='| pbcopy'
alias -g T='| tail'
# view STDOUT with less (e.g. aws s3 cp s3://foo.csv SL)
alias -g SL="- | less"
# command
alias v='/usr/local/bin/nvim'
alias g='/usr/local/bin/git'
alias m='mv'
alias whi='which'
alias br='brew'
alias bu='bundle'
alias dc='docker'
alias cdg='cd $GOPATH/src/github.com'
alias gg='go get'
alias gq='ghq get'
alias tf='terraform'
# jq
alias jq='jq -C'
# echo formatted $PATH
alias path='echo -e ${PATH//:/\\n}'
# open
alias o='open'
alias oo='open .'
# hub
alias ghb='gh repo view --web'
alias ghp='gh pr list --web'
alias ghc='gh pr create --web'
alias ghi='gh issue list --web'
alias ghrp='(){ gh repo view $(ghq list | peco --query "$*" | cut -d "/" -f 2,3) --web }'
# grep
alias gr='grep'
alias ggr='git grep'
# ag (default: Recurse into directories when searching.)
alias agl='ag -l'
alias agg='ag --go'
alias agc='ag -c'
alias agA='ag -A'
alias agB='ag -B'
alias agC='ag -C'
# ls
alias ls='ls -GF'
alias ll='ls -lh'
alias la='ls -lAh'
alias lsw='(){ la $(which $1) }'
# cat
alias c='cat'
# bat
alias b='bat'
alias bR='bat README.md'
alias -s md=bat
alias -s json=bat
alias -s toml=bat
alias -s yaml=bat
alias -s yml=bat
# tar
alias tarc='tar cvfz' # Create a new archive
alias tarx='tar xvfz' # Extract to disk from the archive
alias -s gz='tar -xzvf'

# Google Chrome
alias oc='open -a "Google Chrome.app"'
# search
function s () {
open -a "Google Chrome.app" \
    "https://www.google.com/search?q= $1"
    echo "Now googling $1..."
}
# history
function chrome-history-fzf () {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}
zle -N chrome-history-fzf
bindkey '^y' chrome-history-fzf

# for direnv
if which direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

# aws cli completion (v1)
if type aws_zsh_completer.sh > /dev/null; then
    source "$(which aws_zsh_completer.sh)"
fi

# aws cli completion (v2)
if [ -f "/usr/local/bin/aws_completer" ]; then
    autoload bashcompinit && bashcompinit
    complete -C '/usr/local/bin/aws_completer' aws
fi

### peco ###
# history
function peco-history() {
    local tac="perl -e 'print reverse <>'"
    BUFFER=$(fc -l -n 1 | eval "$tac" | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-history
bindkey '^r' peco-history

# z
function peco-z() {
    local res=$(z | sort -rn | cut -c 12- | peco --query "$LBUFFER")
    if [ -n "$res" ]; then
        BUFFER="cd $res"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-z
bindkey '^z' peco-z

# vim
function peco-file() {
    local filepath=$(ag -l | peco --query "$BUFFER")
    if [ -n "$filepath" ]; then
        BUFFER="nvim $filepath"
        zle accept-line
    fi
}
zle -N peco-file
bindkey '^o' peco-file

# ag + vim
function peco-file-ag() {
    if [ -n "$BUFFER" ]; then
        local filepath=$(ag -l "$BUFFER" | peco)
        if [ -n "$filepath" ]; then
            BUFFER="nvim $filepath"
            zle accept-line
        fi
    fi
}
zle -N peco-file-ag
bindkey '^g' peco-file-ag

# Move the repository dir filtered by ghq
function peco-ghq-cd() {
    local res=$(ghq list -e | peco --query "$LBUFFER")
    if [ -n "$res" ]; then
        local ghqroot="~/repos/src"
        BUFFER="cd ${ghqroot}/${res}"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-ghq-cd
bindkey '^t' peco-ghq-cd

# hub browse -- tree/branch/path/to/file
function peco-hub-browse-file() {
    local filepath=$(ag -l | peco --query "$LBUFFER")
    if [ -n "$filepath" ]; then
        BUFFER="gh browse -- $filepath"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-hub-browse-file
bindkey '^[' peco-hub-browse-file

# hub browse -- issues/number
function peco-hub-browse-issues() {
    local res=$(hub issue 2> /dev/null | peco --query "$LBUFFER")
    if [ -n "$res" ]; then
        n=`echo ${res/]*/}`
        BUFFER="gh browse -- issues/$n"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-hub-browse-issues
bindkey '^]' peco-hub-browse-issues

# hub browse -- commit/hash
function peco-hub-browse-commit() {
    local res=$(git log --oneline --no-color | peco --query "$LBUFFER")
    if [ -n "$res" ]; then
        h=$(echo "$res" | cut -d " " -f 1)
        u=$(gh browse -n)
        BUFFER="open $u/commit/$h"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-hub-browse-commit
bindkey '^\' peco-hub-browse-commit

# peco + aws ec2 describe-instances
function se {
    aws ec2 describe-instances --output text --query 'Reservations[].Instances[].[Tags[?Key==`Name`].Value|[0],InstanceId,PrivateIpAddress,PublicIpAddress,State.Name]' 2> /dev/null | peco
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# defer initialization of nvm
if [ -s "/usr/local/opt/nvm/nvm.sh" ] && [ ! "$(type -w __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    source "/usr/local/opt/nvm/nvm.sh"
    echo "node-dependent command is run! (node $(node --version))"
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
