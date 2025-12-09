-- ==============================================
-- Trouble.nvim - Enhanced diagnostics
-- Unified view of errors, warnings, TODOs, etc.
-- ==============================================

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
