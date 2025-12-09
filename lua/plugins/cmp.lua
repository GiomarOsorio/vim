-- ============================================
-- Plugin: nvim-cmp (Auto-completion)
-- ============================================
-- Powerful auto-completion engine with multiple sources.
-- Provides intelligent completion for LSP, snippets, file paths, and buffer text.
--
-- Features:
--   - LSP-based completion (highest priority)
--   - Snippet expansion with LuaSnip
--   - File path completion
--   - Buffer word completion
--   - Navigate completions with Tab/Shift-Tab
--   - Confirm with Enter
--
-- Keymaps (in insert mode during completion):
--   <CR>    - Confirm selection
--   <Tab>   - Next item
--   <S-Tab> - Previous item
--
-- Completion Sources (in priority order):
--   1. nvim_lsp  - Language server completions
--   2. luasnip   - Snippet completions
--   3. path      - File path completions
--   4. buffer    - Words from current buffer
--
-- Plugin: nvim-cmp
-- Repo: hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP source
    "hrsh7th/cmp-buffer",       -- Buffer text source
    "hrsh7th/cmp-path",         -- File path source
    "L3MON4D3/LuaSnip",         -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet source
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),
      sources = {
        { name = "nvim_lsp" },    -- LSP (highest priority)
        { name = "luasnip" },     -- Snippets
        { name = "path" },        -- File paths
        { name = "buffer" },      -- Words from current buffer
      },
    })
  end
}
