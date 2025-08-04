return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("claudecode").setup({
        api_key = vim.env.ANTHROPIC_API_KEY,
        -- Optional: モデルの設定（デフォルトは claude-3-5-sonnet-20241022）
        model = "claude-3-5-sonnet-20241022",
        -- Optional: 最大トークン数の設定
        max_tokens = 4096,
        -- Optional: システムプロンプトの設定
        system_prompt = "You are an AI assistant helping with Neovim and coding tasks.",
        -- Optional: デバッグモードの設定
        debug = false,
      })
    end,
  },
}