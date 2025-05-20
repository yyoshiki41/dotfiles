return {
  {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
    config = function()
      require("git").setup({
        default_mappings = true,
        keymaps = {
          -- Open blame window
          blame = "<Leader>gb",
          -- Close blame window
          quit_blame = "q",
          -- Open blame commit
          blame_commit = "<CR>",
          -- Quit blame commit
          quit_blame_commit = "q",
          -- Open file/folder in git repository
          browse = "<Leader>go",
          -- Open pull request of the current branch
          open_pull_request = "<Leader>gp",
          -- Create a pull request with the target branch is set in the `target_branch` option
          create_pull_request = "<Leader>gn",
          -- Opens a new diff that compares against the current index
          diff = "<Leader>gd",
          -- Close git diff
          diff_close = "<Leader>gD",
          -- Revert to the specific commit
          revert = "<Leader>gr",
          -- Revert the current file to the specific commit
          revert_file = "<Leader>gR",
        },
        target_branch = "main",
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end)

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end)
          map("n", "<leader>td", gs.toggle_deleted)

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
      
      -- nvim-scrollbarのgitsigns連携を設定
      require("scrollbar.handlers.gitsigns").setup()
    end,
    dependencies = {
      "petertriho/nvim-scrollbar",
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })

      -- コンフリクト検出時のカスタムアクション
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("コンフリクトが検出されました: " .. vim.fn.expand("<afile>"))
        end,
      })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup({
        show = true,
        handle = {
          text = " ",
          blend = 30,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Search = {
            text = { "-", "=" },
            priority = 1,
            highlight = "Search",
          },
          Error = {
            text = { "-", "=" },
            priority = 2,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "-", "=" },
            priority = 3,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "-", "=" },
            priority = 4,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "-", "=" },
            priority = 5,
            highlight = "DiagnosticVirtualTextHint",
          },
          GitAdd = {
            text = "┆",
            priority = 7,
            highlight = "GitSignsAdd",
          },
          GitChange = {
            text = "┆",
            priority = 7,
            highlight = "GitSignsChange",
          },
          GitDelete = {
            text = "▁",
            priority = 7,
            highlight = "GitSignsDelete",
          },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true, -- gitsigns連携を有効化
          handle = true,
          search = false,
        },
      })
    end,
  },
  {
    "yutkat/git-rebase-auto-diff.nvim",
    ft = { "gitrebase" },
    opts = {},
  }
}
