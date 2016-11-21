# とりあえずいるもの
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

### prompt ###
ps_exit="\\(^o^)/"
function precmd_01() {
    if [ $? -ne 0 ]; then
        ps_exit="/(T_T)\\"
    else
        ps_exit="\\(^o^)/"
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_01
PROMPT='[%F{green}%T %F{yellow}%c ${ps_exit}%f]# '
# vcs_info
autoload -Uz vcs_info
# [current directory][git status]
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# List direcory contents
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

### zsh-completions ###
if [ -s ~/.zsh/completions ]; then
    fpath=(~/.zsh/completions $fpath)
fi
if [ -s /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# enable zsh completion
autoload -Uz compinit
compinit -u

# awscli completion
if [ -s "/usr/local/share/zsh/site-functions/_aws" ]; then
    source /usr/local/share/zsh/site-functions/_aws
fi

### zsh_history ###
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# historyを共有
setopt share_history
# 補完時にhistoryを自動的に展開する
setopt hist_expand
# 同じコマンドの場合、古い方を削除
setopt hist_ignore_all_dups

# direcory名で移動
setopt auto_cd
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

### Alias ###
alias v='/usr/local/bin/vim'
alias vi='/usr/local/bin/vim'
alias be='bundle exec'
alias br='brew'
# grep
alias -g G='| grep'
alias gr='grep'
alias ggr='git grep'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'
# ls
alias ls='ls -GF'
alias ll='ls -lh'
alias la='ls -lAh'
# echo formatted $PATH
alias path='echo -e ${PATH//:/\\n}'

# expand childa to $HOME {{{
function expand-to-home() {
  if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
    LBUFFER+="~/"
  else
    zle self-insert
  fi
}
zle -N expand-to-home
bindkey "\\" expand-to-home
# }}}

# for direnv
if which direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi


### Useful Commands ###
# peco + history
function peco-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-history
bindkey '^r' peco-history

# z
. `brew --prefix z`/etc/profile.d/z.sh
# peco + z
function peco-z() {
    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
        BUFFER="cd $res"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-z
bindkey '^\' peco-z

# peco + ghq
function peco-ghq() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $selected_dir"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-ghq
bindkey '^[' peco-ghq

# peco + hub browse
function peco-hub-browse() {
    local res=$(ghq list | grep "github.com" | cut -d "/" -f 2,3 | peco)
    if [ -n "$res" ]; then
        BUFFER="hub browse $res"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-hub-browse
bindkey '^]' peco-hub-browse

# peco + hub issue
function peco-hub-pr() {
    local pr=$(hub issue 2> /dev/null | grep 'pull' | peco --query "$LBUFFER" | sed -e 's/.*( \(.*\) )$/\1/')
    if [ -n "$pr" ]; then
        BUFFER="open $pr"
        zle accept-line
    fi
    zle redisplay
}
zle -N peco-hub-pr
bindkey '^/' peco-hub-pr
