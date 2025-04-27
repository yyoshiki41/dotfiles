vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.syntax = "on"

-- Memory
vim.opt.maxmempattern = 16384

-- 基本設定
vim.cmd("filetype indent on")
vim.cmd("filetype plugin on")
vim.opt.ttyfast = true
if not vim.fn.has('nvim') then
  vim.opt.ttymouse = "xterm2"
  vim.opt.ttyscroll = 3
end

-- ファイル読み込み
vim.opt.autoread = true

-- ビープ音
vim.opt.visualbell = false
vim.opt.errorbells = false
vim.opt.belloff = "all"

-- バックアップとスワップファイル
vim.opt.backup = false
vim.opt.swapfile = false

-- バックスペースの挙動
vim.opt.backspace = {"start", "eol", "indent"}

-- バッファ関連
vim.opt.hidden = true

-- クリップボード
if vim.fn.has('unnamedplus') == 1 then
  vim.opt.clipboard:append({"unnamed", "unnamedplus"})
end

-- IME設定
vim.opt.imdisable = false
vim.opt.iminsert = 0
vim.opt.imsearch = 0
vim.opt.imcmdline = false

-- スペルチェック
vim.opt.spell = true
vim.cmd([[
  highlight clear SpellBad
  highlight SpellBad ctermbg=234 guibg=#1c1c1c
]])
vim.opt.spelllang:append("cjk")

-- 表示設定
if vim.fn.has('nvim') == 1 then
  vim.cmd("colorscheme vim")
end
-- vim.opt.t_Co = 256
vim.opt.modeline = true
vim.opt.showmode = true
vim.opt.number = true
-- vim.opt.title = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.cmd("highlight CursorLineNr term=bold ctermfg=red")

-- 全角スペース表示
vim.cmd([[
  highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
  autocmd BufRead,BufNew * match JpSpace /　/
]])

-- カーソル形状
-- エラーの原因となるコード
-- vim.opt.t_SI = "\27]50;CursorShape=1\x7"
-- vim.opt.t_EI = "\27]50;CursorShape=0\x7"

-- 対応する括弧をハイライト
vim.opt.showmatch = true

-- ステータスライン
vim.opt.laststatus = 2
vim.opt.showcmd = true

-- ワイルドメニュー
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"

-- インデント
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.formatoptions:remove("c")

-- タブ設定
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.shiftround = true

-- タブと特殊文字の可視化
vim.opt.list = true
vim.opt.listchars = {tab = ">-", trail = "-", nbsp = "%", extends = ">", precedes = "<"}

-- スクロール設定
vim.opt.scrolloff = 5

-- 検索設定
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.cmd("highlight Search ctermbg=22 guibg=#005f00")
vim.opt.wrapscan = true

-- ウィンドウ分割位置
vim.opt.splitbelow = true
vim.opt.splitright = true

-- diff表示設定
vim.cmd([[
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
]])

-- ペースト設定
vim.cmd([[
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif
]])

-- マッチペア設定
vim.opt.matchpairs:append("<:>")
