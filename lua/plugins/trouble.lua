-- ============================================
-- Plugin: Trouble (Diagnostics Panel)
-- ============================================
-- Beautiful and unified panel for viewing diagnostics, TODOs, LSP references,
-- quickfix lists, and location lists.
--
-- Features:
--   - Workspace and buffer diagnostics in one view
--   - LSP definitions and references browser
--   - Document symbols outline
--   - Quickfix and location list integration
--   - TODO comments integration
--   - Auto-preview on hover
--   - Auto-close when empty
--
-- Keymaps:
--   <leader>xx  - Toggle workspace diagnostics
--   <leader>xX  - Toggle buffer diagnostics only
--   <leader>xs  - Show document symbols
--   <leader>xl  - Show LSP definitions/references
--   <leader>xL  - Show location list
--   <leader>xq  - Show quickfix list
--   <leader>xt  - Show TODOs (from todo-comments)
--
-- Inside Trouble:
--   <CR>   - Jump to item
--   o      - Jump and keep focus in Trouble
--   q      - Close Trouble
--   <Tab>  - Next item
--   <S-Tab> - Previous item
--
-- Plugin: trouble.nvim
-- Repo: folke/trouble.nvim

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble", "TroubleToggle" },
  keys = {
    -- Main diagnostics toggle
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    -- Buffer diagnostics only
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    -- Document symbols
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    -- LSP definitions and references
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions (Trouble)" },
    -- Location list
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    -- Quickfix list
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
  },
  opts = {
    -- Default configuration
    auto_close = true,     -- Close when no more items
    auto_preview = true,   -- Automatic preview
    focus = true,          -- Automatic focus
    icons = {
      indent = {
        fold_open = " ",
        fold_closed = " ",
      },
    },
  },
}
