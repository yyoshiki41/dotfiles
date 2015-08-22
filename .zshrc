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
# prompt
PROMPT='[%F{green}%B%n%b%f@%F{yellow}%U%m%u%f]# '

# For zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完機能を有効にする
autoload -Uz compinit
compinit -u

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
alias apgraceful='sudo apachectl graceful'
alias apstop='sudo apachectl stop'

# List direcory contents
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
# alias
alias ls='ls -GF'
alias ll='ls -lh'
alias la='ls -lAh'
alias gls='gls --color'

# grep
alias gr='grep'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'

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

# For python
if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
fi
# For MacOS X encoding
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
# For Hadoop / Hive
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.6.0
export HIVE_HOME=/usr/local/Cellar/hive/1.0.0/libexec
# For z
. `brew --prefix`/Cellar/z/1.8/etc/profile.d/z.sh

# For ssh login
if [ -e ~/.ssh/host-colors ]; then
    alias ssh=~/.ssh/host-colors
fi
