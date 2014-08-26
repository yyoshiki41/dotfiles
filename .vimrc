scriptencoding utf-8
set nocompatible

"fileタイプに応じて挙動,色を変える
syntax on
filetype plugin on
filetype indent on

"SSH クライアントの設定によってはマウスが使える（putty だと最初からいける）
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"行番号表示
set number 
"モード表示
set showmode
"編集中のファイル名を表示
set title
"ルーラーの表示
set ruler
"入力中のコマンドをステータスに表示する
set showcmd
"括弧入力時の対応する括弧を表示
set showmatch
"ステータスラインを常に表示
set laststatus=2
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
"カーソルラインを表示する
set cursorline

"オートインデント
set smartindent
set autoindent

"tabの代わりに空白文字挿入
set expandtab
"タブは半角4文字分のスペース
set ts=4 sw=4 sts=0
"フォーマット揃えをコメント以外有効にする
set formatoptions-=c

 "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
"検索結果をハイライトする
set hlsearch
