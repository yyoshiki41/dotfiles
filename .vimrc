scriptencoding utf-8
syntax on
filetype indent on
filetype plugin on
" terminal接続を高速にする
set ttyfast
" VIM 互換にしない
set nocompatible
" 内容が変更されたら自動的に再読み込み
set autoread
" beep音を消す
set vb t_vb=
set novisualbell
" swapfileを作らない
set noswapfile
" insert mode をぬけるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" fileを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" view
" 行番号表示
set number
" mode 表示
set showmode
" 編集中のfile名を表示
set title
" ruler を表示
set ruler
" cursor ラインを表示
set cursorline
" ステータスラインを常に表示
set laststatus=2
" 入力中のコマンドをステータスに表示
set showcmd
" cursor下の括弧に対応するものをhighlight
set showmatch
" autoindent
set smartindent
set autoindent
" コメント以外はフォーマット揃えを有効
set formatoptions-=c
" tab 設定
set noexpandtab
" tab は半角4文字分のスペース
set ts=4 sw=4 sts=0
" tab, EOFなどを可視化
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" normal mode
" <C-j> 2回でescape
noremap <C-j><C-j> <ESC>
noremap! <C-j><C-j> <ESC>
" t 2回でtabedit を開く
nnoremap tt :<C-u>tabe<Space>
" t* でtab移動
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <silent> tf :tabfirst<CR>
nnoremap <silent> tl :tablast<CR>
" move tab
nnoremap tm :<C-u>tabm<Space>
" CTRL-hjkl でwindow移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" space で画面移動
nnoremap <SPACE>   <PageDown>
nnoremap <S-SPACE> <PageUp>
" scroll 時の余白行数
set scrolloff=5
" 0 で行頭, 9で行末
nmap 0 ^
nmap 9 $
" tab で対応ペアに移動
nnoremap <Tab> %
vnoremap <Tab> %
" v 2回で行末まで選択
vnoremap v $h
" cursorから行末まで削除
nnoremap <silent> <C-d> d$

" insert mode
" j 2回でescape
inoremap jj <ESC>
" brackets, quotation mark を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" コンマ入力後に空白
inoremap , ,<Space>
" cursorから行頭まで削除
inoremap <silent> <C-k> <Esc>lc^
" cursorから行末まで削除
inoremap <silent> <C-d> <Esc>lc$

" command-line mode
" % 2回で、アクティブなバッファのpath展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" search
" incremental search
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別しない
set ignorecase
" 検索文字列に大文字が含まれている場合は区別する
set smartcase
" highlight
set hlsearch
" Esc 2回でhighlightをclear
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" / 2回で選択した文字列を検索
vnoremap // y/<C-R>=escape(@",  '\\/.*$^~[]')<CR><CR>
" 検索単語を画面中央に表示
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" 最後までいったら最初に戻る
set wrapscan
