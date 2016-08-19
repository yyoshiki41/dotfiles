if &compatible
  set nocompatible
endif

let mapleader = "\<Space>"
scriptencoding utf-8
syntax on

" --- dein.vim ---
execute "source ~/.vimrc.dein"

filetype indent on
filetype plugin on
" terminal接続を高速にする
set ttyfast
" 前回終了時のcursor 位置で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" 内容が変更されたら自動的に再読み込み
set autoread
" beep音
set t_vb=
set novisualbell
set noerrorbells
set belloff=all
" swapfileを作らない
set noswapfile
" backspace で消せるようにする
set backspace=start,eol,indent
" copy-to-clipboard-without-pbcopy
"set clipboard^=unnamed
"set clipboard^=unnamedplus
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
" set spelllang+=cjk
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
" --- markdown ---
set syntax=markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
let g:markdown_fenced_languages = [
      \  'css',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \  'vim',
      \]

" ---display---
" colors
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
" Show command
set showcmd
" command-line 補完
set wildmenu
set wildmode=longest:full,full
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
set ts=4 sw=4 sts=0
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
nnoremap <S-SPACE> <PageUp>
nnoremap <SPACE> <PageDown>
" scroll 時の余白行数
set scrolloff=5
" 0 で行頭, 9で行末
nnoremap 0 ^
nnoremap 9 $
" tab で対応ペアに移動
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
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]p :setl paste!<CR>:setl paste?<CR>
nnoremap <silent> [toggle]i :setl autoindent!<CR>:setl autoindent?<CR>
nnoremap <silent> [toggle]h :setl hlsearch!<CR>:setl hlsearch?<CR>

" ---vimgrep---
" open quickfix-window
autocmd QuickFixCmdPost *grep* cwindow
" move cursor in quickfix-window
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
" search conflict file using vimgrep
nnoremap vhead :vim<Space>/^<\+\sHEAD$/<Space>

" ---tabline---
" t 2回でtabedit を開く
nnoremap tt :<C-u>tabe<Space>
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
nnoremap <silent> <C-m> gt
nnoremap <silent> <C-n> gT
nnoremap <silent> tf :tabfirst<CR>
nnoremap <silent> tl :tablast<CR>
for n in range(1, 9)
  execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" move tab  ※(引数+1)番目にtabを移動
nnoremap tm :<C-u>tabm<Space>
" --- window ---
" Put the new window below the current one
set splitbelow
" Put the new window right the current one
set splitright

" ---insert mode---
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

" ---command-line---
" % 2回で、アクティブなバッファのpath展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
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

" ---search---
" incremental search
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別しない
set ignorecase
" 検索文字列に大文字が含まれている場合は区別する
set smartcase
" highlight
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

" --- Go ---
au BufWritePre *.go GoFmt
au BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4 completeopt=menu,preview
au FileType go compiler go
" for 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go'] }
let g:syntastic_go_checkers = ['golint']

" --- vim-go ---
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1

augroup go
  autocmd!

  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>t <Plug>(go-def-tab)

  autocmd FileType go nmap <Leader>i <Plug>(go-implements)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <Leader>r <Plug>(go-run)
  autocmd FileType go nmap <Leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>test <Plug>(go-test)

  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  autocmd FileType go nmap <Leader>db <Plug>(go-doc-browser)
augroup END
