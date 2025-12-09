-- ============================================
-- Lazy.nvim - Plugin Manager Bootstrap
-- ============================================
-- This file initializes lazy.nvim, the modern plugin manager for Neovim.
-- It handles automatic installation and plugin loading.
--
-- Plugin Structure:
--   lua/plugins/*.lua        - Core plugins (always loaded)
--   lua/plugins/conditional/ - Optional plugins (controlled by config.lua)
--
-- Commands:
--   :Lazy        - Open lazy.nvim UI
--   :Lazy sync   - Update all plugins
--   :Lazy clean  - Remove unused plugins
--   :Lazy health - Check plugin health
--
-- Repository: https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim with plugin directories
require("lazy").setup({
  { import = "plugins" },             -- Core plugins
  { import = "plugins.conditional" }, -- Conditional plugins (Copilot, Claude)
})
