-- ============================================
-- Plugin: Which-Key (Keymap Discovery)
-- ============================================
-- Displays a popup with available keybindings after you start typing a key sequence.
-- Essential for discovering and remembering keymaps.
--
-- Features:
--   - Shows available keybindings in real-time popup
--   - Groups keymaps by category (file, git, debug, etc.)
--   - 300ms timeout before popup appears
--   - Helps learn and discover shortcuts
--
-- Keymap Groups:
--   <leader>f - File/Find operations (Telescope)
--   <leader>g - Git operations
--   <leader>h - Git hunks (gitsigns)
--   <leader>s - Splits/Windows
--   <leader>x - Diagnostics (Trouble)
--   <leader>c - Code actions
--   <leader>r - Refactoring
--   <leader>d - Debug/DAP
--   <leader>t - Terraform/Terminal
--
-- Usage:
--   - Type <leader> and wait 300ms - popup shows all leader keymaps
--   - Type any key sequence partially to see completions
--
-- Plugin: which-key.nvim
-- Repo: folke/which-key.nvim

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
