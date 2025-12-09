-- Claude Code integration for Neovim
-- Provides AI-assisted coding with Claude
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
