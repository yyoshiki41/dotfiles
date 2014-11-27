scriptencoding utf-8
syntax on
filetype indent on
filetype plugin on
" terminal接続を高速にする
set ttyfast
" 前回終了時のcursor 位置で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" VIM 互換にしない
set nocompatible
" 内容が変更されたら自動的に再読み込み
set autoread
" beep音
set visualbell t_vb=
set noerrorbells
" swapfileを作らない
set noswapfile
" OS のclipbord を使えるようにする
" set clipboard=unnamed
" backspace で消せるようにする
set backspace=start,eol,indent
" insert mode をぬけるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" display
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
" remaping
nnoremap ; :
nnoremap : ;
" CTRL-hjkl でwindow移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" space で画面移動
nnoremap <SPACE> <PageDown>
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
"nnoremap <silent> <C-k> d$

" tabline
" t 2回でtabedit を開く
nnoremap tt :<C-u>tabe<Space>
" show tabline
set showtabline=2
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'),  '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= i . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'tabline()'
" t* でtab移動
nnoremap <silent> <C-n> gt
nnoremap <silent> <C-p> gT
nnoremap <silent> tf :tabfirst<CR>
nnoremap <silent> tl :tablast<CR>
for n in range(1, 9)
  execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" move tab  ※(引数+1)番目に移動
nnoremap tm :<C-u>tabm<Space>

" insert mode
" brackets, quotation mark を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
" コンマ入力後に空白
inoremap , ,<Space>
" emacs key bindings
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Del>
inoremap <C-k> <Esc>lc$
" command+p 時に、autoindent off
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" command-line
" % 2回で、アクティブなバッファのpath展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" emacs key bindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" visual mode
" 選択範囲をbrackets, quotation mark で括る
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" yank後にcursor位置をそのままに
vnoremap y y`>

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
