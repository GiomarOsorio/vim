-- ============================================
-- Neovim Config – Main Entry Point
-- ============================================

-- Load basic options
require("core.options")

-- Load keymaps
require("core.keymaps")

-- Load plugin manager (lazy.nvim)
require("core.lazy")

-- Optional: apply colorscheme defined in config.lua
local config = require("config")

pcall(function()
  vim.cmd("colorscheme " .. config.colorscheme)
end)
