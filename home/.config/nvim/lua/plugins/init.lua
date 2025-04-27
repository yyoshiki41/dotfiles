-- lazy.nvim はこのディレクトリ内の全てのLuaファイルを自動的にロードします。
-- 各ファイルには、プラグイン設定を含む形式で「return { ... }」を記述します。
-- 
-- 以下のようなファイル構成になっています：
-- lua/plugins/
--   ├── init.lua      (オプション)
--   ├── lsp.lua       (LSP関連の設定)
--   ├── treesitter.lua(Treesitterと関連プラグインの設定)
--   └── ui.lua        (UI関連のプラグイン設定)
--
-- 参考: https://lazy.folke.io/usage/structuring

return {
  -- このファイルに共通のプラグインや依存関係の少ないプラグインを記述することもできます
  -- 例：
  -- "tpope/vim-surround",
  -- "tpope/vim-commentary",
}
