-- ============================================
-- Plugin: Claude Code (Conditional)
-- ============================================
-- Anthropic's Claude AI integration for Neovim.
-- Only loads if config.enable_claudecode is true in lua/config.lua
--
-- Features:
--   - AI-assisted coding with Claude
--   - Terminal-based interface
--   - Git repository awareness
--   - Contextual code understanding
--   - Code generation and refactoring suggestions
--
-- Keymaps:
--   <leader>ac  - Toggle Claude Code terminal
--   <leader>aC  - Open Claude Code
--   <C-\>       - Toggle from terminal mode
--
-- Window Settings:
--   - Opens in bottom 40% of screen
--   - Automatically enters insert mode
--   - Git root detection for context
--
-- Requirements:
--   - Claude Code CLI installed and configured
--   - Anthropic API key set up
--   - Active Anthropic account
--
-- Enable/Disable:
--   Set config.enable_claudecode = true/false in lua/config.lua
--
-- Plugin: claude-code.nvim
-- Repo: anthropics/claude-code.nvim

local config = require("config")
if not config.enable_claudecode then
  return {}
end

return {
  {
    "anthropics/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        -- Terminal window settings
        window = {
          height_ratio = 0.4,
          position = "bottom",
          enter_insert = true,
          hide_numbers = true,
        },
        -- Git integration
        git = {
          use_git_root = true,
        },
        -- Keymaps (set to false to disable default keymaps)
        keymaps = {
          toggle = {
            normal = "<leader>ac",
            terminal = "<C-\\>",
          },
          window_navigation = true,
        },
        -- Refresh interval for terminal buffer (ms)
        refresh_interval = 100,
      })
    end,
    keys = {
      { "<leader>ac", desc = "Toggle Claude Code" },
      { "<leader>aC", "<cmd>ClaudeCodeOpen<cr>", desc = "Open Claude Code" },
    },
  },
}
