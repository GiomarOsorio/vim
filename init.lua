-- ============================================
-- Neovim Configuration - Main Entry Point
-- ============================================
-- This is the first file Neovim loads. It orchestrates the entire configuration
-- by loading modules in the correct order for optimal performance and functionality.
--
-- Load Order:
-- 1. Core options (vim settings)
-- 2. Core keymaps (keyboard shortcuts)
-- 3. Plugin manager (lazy.nvim loads all plugins)
-- 4. Colorscheme (applied after plugins are loaded)

-- ============================================
-- STEP 1: Load Core Vim Options
-- ============================================
-- Sets fundamental Neovim behavior: line numbers, tabs, splits, etc.
-- These are loaded first to ensure consistent behavior before plugins load
require("core.options")

-- ============================================
-- STEP 2: Load Global Keymaps
-- ============================================
-- Defines core keyboard shortcuts that work with or without plugins
-- Includes QWERTY and Dvorak Programming layout support
require("core.keymaps")

-- ============================================
-- STEP 3: Initialize Plugin Manager
-- ============================================
-- Loads lazy.nvim which handles all plugin installation and loading
-- Plugins are lazy-loaded for faster startup times
require("core.lazy")

-- ============================================
-- STEP 4: Apply Colorscheme
-- ============================================
-- Load and apply the colorscheme defined in lua/config.lua
-- Uses pcall (protected call) to prevent errors if colorscheme is missing
local config = require("config")

pcall(function()
	vim.cmd("colorscheme " .. config.colorscheme)
end)
