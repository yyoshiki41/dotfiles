return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        transparent_bg = true,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
        },
        options = {
          show_source = {
            enabled = true,
            if_many = false,
          },
          multilines = {
            enabled = true,
            always_show = false,
          },
          show_all_diags_on_cursorline = true,
          overflow = {
            mode = "wrap",
          },
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  }
} 