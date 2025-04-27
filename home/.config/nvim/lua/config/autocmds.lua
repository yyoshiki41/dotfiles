-- オートコマンド設定
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- 前回終了時のカーソル位置で起動
create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal g`\"")
    end
  end
})

-- 新しいファイルを作成する際にディレクトリも作成
create_autocmd("BufNewFile", {
  pattern = "*",
  callback = function()
    local dir = vim.fn.fnamemodify(vim.fn.bufname('%'), ':p:h')
    vim.fn.mkdir(dir, "p")
  end
})

-- カーソル行のハイライト (現在のウィンドウのみ)
local cursorline_group = create_augroup("CursorLine", { clear = true })
create_autocmd({"WinLeave"}, {
  group = cursorline_group,
  pattern = "*",
  command = "set nocursorline"
})
create_autocmd({"WinEnter", "BufRead"}, {
  group = cursorline_group,
  pattern = "*",
  command = "set cursorline"
})

-- 全角スペースのハイライト
create_autocmd({"BufRead", "BufNew"}, {
  pattern = "*",
  command = "match JpSpace /　/"
})

-- Quickfixウィンドウを自動的に開く
create_autocmd("QuickFixCmdPost", {
  pattern = "*grep*",
  command = "cwindow"
})

-- スペルチェック設定
local spell_group = create_augroup("SpellCheck", { clear = true })
create_autocmd({"BufReadPost", "BufNewFile", "Syntax"}, {
  group = spell_group,
  pattern = "*",
  callback = function()
    local syntax = vim.fn.execute("syntax")
    vim.opt.spell = true
    if string.find(syntax, "/<comment>") then
      vim.cmd("syntax spell default")
      vim.cmd("syntax match SpellMaybeCode /\\<\\h\\l*[_A-Z]\\h\\{-}\\>/ contains=@NoSpell transparent containedin=Comment contained")
    else
      vim.cmd("syntax spell toplevel")
      vim.cmd("syntax match SpellMaybeCode /\\<\\h\\l*[_A-Z]\\h\\{-}\\>/ contains=@NoSpell transparent")
    end
    vim.cmd("syntax cluster Spell add=SpellNotAscii,SpellMaybeCode")
  end
})

-- Markdownの設定
create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.md",
  command = "set filetype=markdown"
})

-- JSON設定
create_autocmd("FileType", {
  pattern = "json",
  command = "setlocal foldmethod=syntax foldlevel=2"
})

-- YAML設定
create_autocmd("FileType", {
  pattern = "yaml",
  command = "setlocal foldmethod=indent"
})

-- シェルスクリプトの新規作成時
local shell_group = create_augroup("MyShell", { clear = true })
create_autocmd("BufNewFile", {
  group = shell_group,
  pattern = "*.sh",
  command = "put='#!/bin/bash' | exe ':g/^$/d'"
})

-- Go言語設定
create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.go",
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4 completeopt=menu,menuone,preview"
})

create_autocmd("FileType", {
  pattern = "go",
  command = "compiler go"
})

-- Go言語カスタム設定
local go_group = create_augroup("MyGolang", { clear = true })
create_autocmd("FileType", {
  group = go_group,
  pattern = "go",
  command = ":highlight goExtraVars cterm=bold ctermfg=136"
})

create_autocmd("FileType", {
  group = go_group,
  pattern = "go",
  command = ":match goExtraVars /\\<ok\\>\\|\\<err\\>/"
})

-- JavaScript設定
local js_group = create_augroup("MyJavaScript", { clear = true })
create_autocmd("FileType", {
  group = js_group,
  pattern = "javascript",
  command = "setlocal shiftwidth=2 expandtab cindent"
})
