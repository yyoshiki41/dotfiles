return {
  -- FZF関連
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    config = function()
      -- FZF設定
      vim.env.FZF_DEFAULT_OPTS = "--layout=reverse"
    end,
  },
  
  -- Easy-Motion
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.g.EasyMotion_do_mapping = 0
    end,
  },
  
  -- Open-Browser
  {
    "tyru/open-browser.vim",
    config = function()
      vim.g.openbrowser_search_engines = {
        github = 'https://github.com/search?q={query}',
        ['translate-ja'] = 'https://translate.google.co.jp/?hl=ja#view=home&op=translate&sl=en&tl=ja&text={query}',
      }
    end,
  },
  
  -- Markdown関連
  {
    "previm/previm",
    ft = { "md", "markdown" },
    config = function()
      vim.g.markdown_fenced_languages = {
        'bash=sh',
        'xml',
        'vim',
        'ruby',
        'python',
        'javascript',
        'js=javascript',
        'json=javascript',
        'sass',
        'css',
      }
      vim.g.previm_open_cmd = 'open -a "Google Chrome.app"'
    end,
  },
  
  -- Terraform
  {
    "hashivim/vim-terraform",
    ft = { "tf", "tfvars", "tfstate" },
    config = function()
      vim.g.terraform_fmt_on_save = 1
    end,
  },
  
  -- その他のファイルタイプ関連
  {
    "jjo/vim-cue",
    ft = { "cue" },
  },
  
  -- その他のプラグイン
  "editorconfig/editorconfig-vim",
  "github/copilot.vim",
} 