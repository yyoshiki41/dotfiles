return {
  {
    "prabirshrestha/vim-lsp",
    dependencies = {
      "mattn/vim-lsp-settings",
      "prabirshrestha/asyncomplete.vim",
      "prabirshrestha/asyncomplete-lsp.vim",
    },
    config = function()
      -- vim-lsp設定
      vim.g.lsp_settings_filetype_vue = {'typescript-language-server', 'volar-server'}
      
      -- LSP関連のキーマッピングを設定
      local create_augroup = vim.api.nvim_create_augroup
      local create_autocmd = vim.api.nvim_create_autocmd
      
      local lsp_group = create_augroup("LspConfig", { clear = true })
      create_autocmd("FileType", {
        group = lsp_group,
        pattern = "*",
        callback = function()
          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>t', ':LspDefinition<CR>', opts)
          vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>v', ':<C-u>vs<Space> | :LspDefinition<CR>', opts)
          vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>s', ':<C-u>split<Space> | :LspDefinition<CR>', opts)
          vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>r', ':LspReferences<CR>', opts)
          vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>h', ':LspHover<CR>', opts)
        end
      })
    end,
  }
} 
