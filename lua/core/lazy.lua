-- ============================================
-- Lazy.nvim – Plugin Manager
-- ============================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.conditional" },
})
