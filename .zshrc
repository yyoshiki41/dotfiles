# とりあえずいるもの
export LANG=ja_JP.UTF-8
# '#' 以降をコメントとして扱う
setopt interactive_comments

# prompt
PROMPT='[%F{green}%B%n%b%f@%F{yellow}%U%m%u%f]# '
RPROMPT='[%F{blue}%d%f]'

# 補完機能を有効にする
autoload -Uz compinit
compinit

# スペルチェック
setopt correct

# global alias
alias v='/usr/bin/vim'
alias gcc='gcc-4.9'
alias -g L='| less'
alias -g G='| grep'
#alias forward-mysql=""
#alias mysql-stage=""
# apache
alias apstart='sudo apachectl start'
alias aprestart='sudo apachectl restart'
alias apstop='sudo apachectl stop'

# List direcory contents
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias ls='ls -GF'
alias ll='ls -lh'
alias la='ls -lAh'
alias gls='gls --color'

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# ディレクトリ名で cd
setopt auto_cd
# 出力時8ビットを通す
setopt print_eight_bit

# historyの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# 直前と同じコマンドをhistoryに追加しない
setopt hist_ignore_dups
# 補完時にhistoryを自動的に展開する
setopt hist_expand
# historyを共有
setopt share_history

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'

# emacs 風キーバインドにする
bindkey -e

# beep音を鳴らさない
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control
