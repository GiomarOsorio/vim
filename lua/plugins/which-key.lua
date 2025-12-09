-- ==============================================
-- Which-key - Keymap discovery
-- Shows a window with all available keymaps
-- ==============================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- Keymap groups configuration
    -- This helps organize and display shortcuts better
    spec = {
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk (git)" },
      { "<leader>s", group = "split/window" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>c", group = "code" },
      { "<leader>r", group = "refactor" },
      { "<leader>d", group = "debug/diagnostic" },
      { "<leader>t", group = "terraform/terminal" },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
    },
  },
}
