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

# Control system resources
ulimit -u 512
ulimit -n 4096

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
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# enable zsh completion
autoload -Uz compinit
compinit -u

### zsh_history ###
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# 直前と同じコマンドをhistoryに追加しない
setopt hist_ignore_dups
# 補完時にhistoryを自動的に展開する
setopt hist_expand
# historyを共有
setopt share_history

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
alias v='/usr/bin/vim'
alias be='bundle exec'
# grep
alias -g G='| grep'
alias gr='grep'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'
# ls
alias ls='ls -GF'
alias ll='ls -lh'
alias la='ls -lAh'
# format $PATH
alias path='echo -e ${PATH//:/\\n}'

### Useful Commands ###
# z
. `brew --prefix`/Cellar/z/1.8/etc/profile.d/z.sh
# Use peco + ghq
function peco-src() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
