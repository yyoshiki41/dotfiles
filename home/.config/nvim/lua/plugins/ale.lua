return {
  {
    "dense-analysis/ale",
    config = function()
      -- ALE設定
      vim.g.ale_sign_column_always = 1
      vim.g.ale_set_loclist = 0
      vim.g.ale_set_quickfix = 1
      vim.g.ale_linters_explicit = 1
      vim.g.ale_echo_msg_format = '[%severity%] %linter%: %s'
      vim.g.ale_floating_preview = 1
      vim.g.ale_lsp_suggestions = 1
      
      vim.g.ale_javascript_prettier_use_local_config = 1
      
      -- ファイルタイプエイリアス
      vim.g.ale_linter_aliases = {
        vue = {'vue', 'javascript'},
        typescriptreact = {'typescript'},
      }
      
      -- リンター設定
      vim.g.ale_linters = {
        vue = {'eslint', 'vls', 'volar'},
        typescriptreact = {'eslint', 'prettier'},
      }
      
      -- フィクサー設定
      vim.g.ale_fixers = {
        graphql = {'prettier'},
        javascript = {'prettier'},
        javascriptreact = {'prettier'},
        json = {'prettier'},
        jsonnet = {'jsonnetfmt'},
        jsx = {'prettier'},
        markdown = {'prettier'},
        proto = {'buf-format'},
        python = {'isort'},
        sh = {'shfmt'},
        sql = {'sqlfluff'},
        tsx = {'prettier'},
        typescript = {'prettier'},
        typescriptreact = {'prettier'},
        vue = {'prettier'},
        yaml = {'prettier'},
      }
      
      -- 無視するリンター
      vim.g.ale_linters_ignore = {
        go = {''},
        proto = {''},
      }
      
      -- 保存時に自動修正
      vim.g.ale_fix_on_save = 1
      vim.g.ale_sh_shfmt_options = '-i 2'
    end,
  }
} 