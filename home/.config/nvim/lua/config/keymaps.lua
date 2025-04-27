-- キーマッピング設定
local keymap = vim.keymap.set

------------------
-- Normal Mode
------------------
-- 基本マッピング
keymap('n', ';', ':')
keymap('n', ':', ';')

-- クリップボード
keymap('n', '<C-p>', '"+p')

-- ウィンドウ移動
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')
keymap('n', '<C-h>', '<C-w>h')

-- スクロール
keymap('n', '<S-Space>', '<PageUp>')
keymap('n', '<Space>', '<PageDown>')

-- 行移動
keymap('n', '0', '^')
keymap('n', '9', '$')

-- 表示行の上下移動
keymap('n', 'gj', 'gj<SID>g')
keymap('n', 'gk', 'gk<SID>g')
vim.cmd([[
nnoremap <script> <SID>gj gj<SID>g
nnoremap <script> <SID>gk gk<SID>g
nmap <SID>g <Nop>
]])

-- 括弧間の移動
keymap('n', '<Tab>', '%')
keymap('v', '<Tab>', '%')

-- 選択範囲の拡張
keymap('v', 'v', '$h')

-- 設定トグル
vim.cmd([[
nnoremap [toggle] <Nop>
nnoremap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]p :setl paste!<CR>:setl paste?<CR>
nnoremap <silent> [toggle]i :setl autoindent!<CR>:setl autoindent?<CR>
nnoremap <silent> [toggle]h :setl hlsearch!<CR>:setl hlsearch?<CR>
]])

-- リーダーキー
keymap('n', '<Leader>w', ':w<CR>')
keymap('n', '<Leader>q', ':q<CR>')

-- バッファ操作
keymap('n', '<Leader>p', ':bp<CR>', { silent = true })
keymap('n', '<Leader>n', ':bn<CR>', { silent = true })
keymap('n', '<Leader>gf', '<C-w>gf<CR>', { silent = true })

-- Quickfix
keymap('n', '[q', ':cprevious<CR>')
keymap('n', ']q', ':cnext<CR>')
keymap('n', '[Q', ':<C-u>cfirst<CR>')
keymap('n', ']Q', ':<C-u>clast<CR>')
keymap('n', 'vhead', ':vim<Space>/^<\\+\\sHEAD$/<Space>')

-- タブ操作
keymap('n', '::', ':<C-u>tabe<Space>')
keymap('n', 'tt', ':<C-u>tabe<Space>')
keymap('n', 'tm', ':<C-u>tabm<Space>')
keymap('n', '<C-n>', 'gt', { silent = true })
keymap('n', '<C-m>', 'gT', { silent = true })
keymap('n', '<C-s>', 'gT', { silent = true })
keymap('n', 'tf', ':tabfirst<CR>', { silent = true })
keymap('n', 'tl', ':tablast<CR>', { silent = true })

-- タブライン設定
vim.opt.showtabline = 2
vim.cmd([[
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'),  '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
function! s:tabline()
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
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'tabline()'
]])

-- タブ番号へのジャンプ
for i = 1, 9 do
  keymap('n', 't'..i, ':<C-u>tabnext'..i..'<CR>', { silent = true })
end

------------------
-- Insert Mode
------------------
keymap('i', 'jj', '<ESC>', { silent = true })
keymap('i', '{', '{}<LEFT>')
keymap('i', '[', '[]<LEFT>')
keymap('i', '(', '()<LEFT>')
keymap('i', '"', '""<LEFT>')
keymap('i', "'", "''<LEFT>")
keymap('i', ',', ',<Space>')
keymap('i', '<C-a>', '<Home>')
keymap('i', '<C-e>', '<End>')
keymap('i', '<C-b>', '<Left>')
keymap('i', '<C-f>', '<Right>')
keymap('i', '<C-d>', '<Del>')
keymap('i', '<C-k>', '<ESC>lc$')
keymap('i', '<ESC>', '<ESC>:set iminsert=0<CR>', { silent = true })

------------------
-- Command-line Mode
------------------
vim.cmd([[
cnoremap <expr> ;; getcmdtype() == ':' ? expand('%:h').'/' : ';;'
]])
keymap('c', '<C-a>', '<Home>')
keymap('c', '<C-e>', '<End>')
keymap('c', '<C-b>', '<Left>')
keymap('c', '<C-f>', '<Right>')
keymap('c', '<C-d>', '<Del>')
keymap('c', '<C-k>', "<C-\\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>")

------------------
-- Visual Mode
------------------
keymap('v', '<C-y>', '"+y')
keymap('v', '<C-p>', '"+p')
keymap('v', '{', '"zdi{<C-R>z}<ESC>')
keymap('v', '[', '"zdi[<C-R>z]<ESC>')
keymap('v', '(', '"zdi(<C-R>z)<ESC>')
keymap('v', '"', '"zdi"<C-R>z"<ESC>')
keymap('v', "'", "\"zdi'<C-R>z'<ESC>")
keymap('v', 'y', 'y`>')

-- 選択範囲のペースト時に元のレジスタを保持する
vim.cmd([[
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()
]])

------------------
-- 検索関連
------------------
keymap('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })
keymap('n', 'n', 'nzz')
keymap('n', 'N', 'Nzz')
keymap('n', '*', '*zz')
keymap('n', '#', '#zz')
keymap('n', 'g*', 'g*zz')
keymap('n', 'g#', 'g#zz')

-- 選択範囲を検索
vim.cmd([[
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
]])

-- 検索パターンのエスケープ
vim.cmd([[
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
]])

------------------
-- プラグイン固有のキーマップ
------------------
-- ALE
keymap('n', '<Leader>j', '<Plug>(ale_previous_wrap)', { silent = true })
keymap('n', '<Leader>k', '<Plug>(ale_next_wrap)', { silent = true })

-- vim-lsp
vim.cmd([[
autocmd FileType * nnoremap <Leader>t :LspDefinition<CR>
autocmd FileType * nnoremap <Leader>v :<C-u>vs<Space>\| :LspDefinition<CR>
autocmd FileType * nnoremap <Leader>s :<C-u>split<Space>\| :LspDefinition<CR>
autocmd FileType * nnoremap <Leader>r :LspReferences<CR>
autocmd FileType * nnoremap <Leader>h :LspHover<CR>
]])

-- previm
keymap('n', '<Leader>mp', ':<C-u>PrevimOpen<CR>', { silent = true })

-- fzf
keymap('n', '<Leader>b', ':Buffers<CR>', { silent = true })
keymap('n', '<C-o>', ':Files<CR>', { silent = true })
keymap('n', '<C-g>', ':Ag<CR>', { silent = true })
keymap('n', '<C-g><C-w>', ':Ag <C-r><C-w><CR>', { silent = true })

-- easy-motion
keymap('', '<Leader>f', '<Plug>(easymotion-bd-f)')
keymap('n', '<Leader>f', '<Plug>(easymotion-overwin-f)')
keymap('n', 's', '<Plug>(easymotion-overwin-f2)')
keymap('v', 's', '<Plug>(easymotion-bd-f2)')
keymap('', '<Leader>l', '<Plug>(easymotion-bd-jk)')
keymap('n', '<Leader>l', '<Plug>(easymotion-overwin-line)')

-- open-browser
keymap('n', '<Leader>m', ':OpenBrowserSearch<Space>')
keymap('n', '<Leader>M', ':OpenBrowserSearch<Space>')
keymap('n', '<Leader>o', '<Plug>(openbrowser-smart-search)')

-- Go specific keymaps
vim.cmd([[
augroup MyGolang
  autocmd!
  autocmd FileType go nnoremap <C-[> :GoDef<CR>
  autocmd FileType go nmap <C-t> :GoDefPop<CR>
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>e <Plug>(go-vet)
  autocmd FileType go nmap <Leader>c <Plug>(go-callers)
  autocmd FileType go nmap <Leader>r <Plug>(go-referrers)
  autocmd FileType go nmap <Leader>i <Plug>(go-implements)
  autocmd FileType go nmap <Leader>gi <Plug>(go-iferr)
  autocmd FileType go nmap <Leader>gb <Plug>(go-build)
  autocmd FileType go nmap <Leader>gs <Plug>(go-test)
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  autocmd FileType go nmap <Leader>db <Plug>(go-doc-browser)
augroup END
]])
