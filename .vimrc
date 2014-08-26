scriptencoding utf-8
" fileタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on
" ターミナル接続を高速にする
set ttyfast
" VIM互換にしない
set nocompatible
" 内容が変更されたら自動的に再読み込み
set autoread

" マウスが使える
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" 行番号表示
set number 
" モード表示
set showmode
" 編集中のファイル名を表示
set title
" rulerの表示
set ruler
" カーソルラインを表示する
set cursorline
" ステータスラインを常に表示
set laststatus=2
" 入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" fileを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" swapfileを作らない
set noswapfile

" オートインデント
set smartindent
set autoindent

" tab設定
set noexpandtab
" tabは半角4文字分のスペース
set ts=4 sw=4 sts=0
" tab,EOFなどを可視化
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" フォーマット揃えをコメント以外有効にする
set formatoptions-=c

" 検索結果をハイライトする
set hlsearch
" 検索文字を打ち込むと即検索する
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
