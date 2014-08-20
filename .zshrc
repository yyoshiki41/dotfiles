# シンプルな zshrc
 
# 補完機能を有効にする
autoload -Uz compinit
compinit
 
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
 
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
alias v='/usr/bin/vim'
# List direcory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias gcc='gcc-4.9'

#alias forward-mysql=""
#alias mysql-stage=""
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
 
 
# emacs 風キーバインドにする
bindkey -e
 
# その他とりあえずいるもの
export LANG=ja_JP.UTF-8
 
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# フローコントロールを無効にする
setopt no_flow_control
 
# '#' 以降をコメントとして扱う
setopt interactive_comments

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'

# prompt
PROMPT='[%F{green}%B%n%b%f@%F{yellow}%U%m%u%f]# '
RPROMPT='[%F{blue}%d%f]'
