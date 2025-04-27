let mapleader = "\<Space>"
scriptencoding utf-8
syntax on

" memory
set maxmempattern=16384

filetype indent on
filetype plugin on
" Indicate fast terminal conn for faster redraw
set ttyfast
if !has('nvim')
  set ttymouse=xterm2 " Indicate terminal type for mouse codes
  set ttyscroll=3 " Speedup scrolling
endif
" 前回終了時のcursor 位置で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" Create the directory which a new file will reside in
autocmd BufNewFile * :exe ': !mkdir -p ' . escape(fnamemodify(bufname('%'),':p:h'),'#% \\')
" 内容が変更されたら自動的に再読み込み
set autoread
" beep音
set t_vb=
set novisualbell
set noerrorbells
set belloff=all
" Do not create backup and swapfile
set nobackup
set noswapfile
" Makes backspace key more powerful.
set backspace=start,eol,indent
" Buffer should still exist if window is closed
set hidden
" Copy to clipboard without pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif
" insert mode をぬけるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" spell check
set spell
highlight clear SpellBad
highlight SpellBad ctermbg=234 guibg=#1c1c1c
" spell check から日本語を除外
set spelllang+=cjk
fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END
  set spell
  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif
  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc
augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

" ---display---
" colors
if has('nvim')
  colorscheme vim
endif
set t_Co=256
" Enable modeline
set modeline
set showmode
" Show line number
set number
" Show file name
set title
" Show ruler
set ruler
" Show cursor line
set cursorline
highlight CursorLineNr term=bold ctermfg=red
" 全角spaceを　で表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
autocmd BufRead,BufNew * match JpSpace /　/
" Show cursor line (Only current window)
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
" Change cursor shape in different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" cursor下の括弧に対応するものをhighlight
set showmatch
" Show status line
set laststatus=2
" Show me what I'm typing
set showcmd
" Turn on the WiLd menu
set wildmenu
set wildmode=longest:full,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" auto indent
set smartindent
set autoindent
" コメント以外はフォーマット揃えを有効
set formatoptions-=c
" tab 設定
set noexpandtab
set smarttab
set shiftround
" tab は半角4文字分のスペース
"set ts=4 sw=4 sts=0
" tab, EOFなどを可視化
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<

" ---normal mode---
" remaping
nnoremap ; :
nnoremap : ;
" Paste +register(= the clipboard register)
nnoremap <C-p> "+p
" CTRL-hjkl でwindow移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" space でwindow移動
nnoremap <S-Space> <PageUp>
nnoremap <Space> <PageDown>
" scroll 時の余白行数
set scrolloff=5
" 0 で行頭, 9で行末
nnoremap 0 ^
nnoremap 9 $
" 表示行の上下に移動
nmap gj gj<SID>g
nmap gk gk<SID>g
nnoremap <script> <SID>gj gj<SID>g
nnoremap <script> <SID>gk gk<SID>g
nmap <SID>g <Nop>
" Go to newer cursor position in jump list using tab keyboard
nnoremap <Tab> %
vnoremap <Tab> %
" Highlight when CursorMoved
set cpoptions-=m
set matchtime=1
" Add square bracket
set matchpairs+=<:>
" v 2回で行末まで選択
vnoremap v $h
" T + ? で各種設定のtoggle
nnoremap [toggle] <Nop>
nnoremap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]p :setl paste!<CR>:setl paste?<CR>
nnoremap <silent> [toggle]i :setl autoindent!<CR>:setl autoindent?<CR>
nnoremap <silent> [toggle]h :setl hlsearch!<CR>:setl hlsearch?<CR>
" Use <Leader>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
" buffer
nnoremap <silent> <Leader>p :bp<CR>
nnoremap <silent> <Leader>n :bn<CR>
" +file_in_path
nnoremap <silent> <Leader>gf <C-w>gf<CR>

" --- vimgrep ---
" open quickfix-window
autocmd QuickFixCmdPost *grep* cwindow
" move cursor in quickfix-window
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
" search conflict file using vimgrep
nnoremap vhead :vim<Space>/^<\+\sHEAD$/<Space>

" --- tabline ---
" open tabe edit
nnoremap :: :<C-u>tabe<Space>
nnoremap tt :<C-u>tabe<Space>
" move tab  ※(引数+1)番目にtabを移動
nnoremap tm :<C-u>tabm<Space>
" show tabline
set showtabline=2
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'),  '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:tabline()  "{{{
  let s = ''
  for l:i in range(1, tabpagenr('$'))
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
" C-m を当てたいが効かない
nnoremap <C-m> gT
nnoremap <silent> <C-s> gT
nnoremap <silent> tf :tabfirst<CR>
nnoremap <silent> tl :tablast<CR>
for n in range(1, 9)
  execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" --- window ---
" Put the new window below the current one
set splitbelow
" Put the new window right the current one
set splitright

" ---insert mode---
inoremap <silent> jj <ESC>
" Map auto complete of {, [, (, ", '
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
inoremap <C-k> <ESC>lc$
" command+p 時に、autoindent off
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" ---command-line---
" アクティブなバッファのpath展開
cnoremap <expr> ;; getcmdtype() == ':' ? expand('%:h').'/' : ';;'
" emacs key bindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" ---visual mode---
" Use +register(= the clipboard register)
vnoremap <C-y> "+y
vnoremap <C-p> "+p
" 選択範囲をbrackets, quotation mark で括る
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" yank後にcursor位置を末尾に
vnoremap y y`>
" Replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()

" ---search---
" Show the match while typing
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別しない
set ignorecase
" 検索文字列に大文字が含まれている場合は区別する
set smartcase
" Highlight found searches
set hlsearch
highlight Search ctermbg=22 guibg=#005f00
" Esc 2回でhighlightをclear
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
" 検索単語を画面中央に表示
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" 最後までいったら最初に戻る
set wrapscan
" 選択範囲を検索
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
" /{pattern}(?{pattern}) で/(?)をauto escape
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" --- vimdiff ---
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" --- json ---
autocmd FileType json setlocal foldmethod=syntax foldlevel=2
" --- yaml ---
autocmd FileType yaml setlocal foldmethod=indent

" --- shell ---
augroup MyShell
  autocmd!
  autocmd BufNewFile *.sh put='#!/bin/bash' | exe ':g/^$/d'
augroup END

" --- Go ---
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 completeopt=menu,menuone,preview
au FileType go compiler go

" grep
nnoremap <silent> <C-g>      :Ag<CR>
nnoremap <silent> <C-g><C-w> :Ag <C-r><C-w><CR>
