return {
  {
    "fatih/vim-go",
    ft = { "go", "template" },
    config = function()
      -- Go言語設定
      vim.g.go_fmt_fail_silently = 0
      vim.g.go_fmt_command = "goimports"
      vim.g.go_autodetect_gopath = 1
      vim.g.go_auto_sameids = 0
      vim.g.go_auto_type_info = 1
      vim.g.go_list_type = "quickfix"
      vim.g.go_def_mode = "gopls"
      vim.g.go_metalinter_enabled = {'vet', 'golint'}
      vim.g.go_metalinter_autosave = 0
      vim.g.go_metalinter_autosave_enabled = {'golint', 'vet'}
      vim.g.go_auto_sameids = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_build_constraints = 1
      
      -- ハイライト設定
      vim.g.go_highlight_format_strings = 1
      vim.g.go_highlight_build_constraints = 1
      vim.g.go_highlight_generate_tags = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_methods = 1
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_extra_types = 1
      vim.g.go_highlight_fields = 0
      
      -- 遅くなるので無効化
      vim.g.go_highlight_structs = 0
      vim.g.go_highlight_interfaces = 0
      vim.g.go_highlight_operators = 0
      
      -- 定義済み識別子のハイライト（nil, iotaなど）
      vim.cmd("hi link goPredefinedIdentifiers Identifier")
    end,
  },
  {
    "sebdah/vim-delve",
    ft = { "go" },
  },
} 