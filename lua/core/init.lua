-- ============================================
-- Core Configuration Loader
-- ============================================
-- This file orchestrates the loading of all core Neovim configurations.
-- Load order matters: options -> keymaps -> autocmds -> plugins -> LSP
--
-- Note: This file is NOT used by init.lua directly.
-- It exists for alternative entry points or testing.
-- The main init.lua loads these modules individually for better control.

-- 1. General options (must load first)
require("core.options")

-- 2. Global keymaps (depends on options for leader key)
require("core.keymaps")

-- 3. Autocommands (depends on keymaps for some integrations)
require("core.autocmds")

-- 4. Plugin manager (loads all plugins)
require("core.lazy")

-- 5. LSP configurations (depends on plugins being loaded)
require("lsp")
