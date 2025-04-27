-- ハイライト設定
local cmd = vim.cmd

-- スペルチェックのハイライト
cmd([[
  highlight clear SpellBad
  highlight SpellBad ctermbg=234 guibg=#1c1c1c
]])

-- カーソルラインのハイライト
cmd("highlight CursorLineNr term=bold ctermfg=red")

-- 全角スペースのハイライト
cmd("highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue")

-- 検索結果のハイライト
cmd("highlight Search ctermbg=22 guibg=#005f00")

-- diff表示のハイライト
cmd([[
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
]])

-- Go言語の特別な変数のハイライト
cmd("highlight goExtraVars cterm=bold ctermfg=136")
