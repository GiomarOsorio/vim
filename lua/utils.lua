-- ============================================
-- Utility Functions
-- ============================================
-- This module provides reusable helper functions used throughout the configuration.
-- It includes logging, conditional plugin loading, command execution, and keymap helpers.
--
-- Usage:
--   local utils = require("utils")
--   utils.log("Debug message")
--   utils.map("n", "<leader>x", ":close<CR>", { desc = "Close window" })

local M = {}

-- ============================================
-- Debug Logging
-- ============================================

--- Log debug messages to Neovim's notification system
--- Only displays messages when config.debug is enabled in config.lua
--- @param msg string The message to log
--- @usage utils.log("LSP server initialized")
function M.log(msg)
    local config = require("config")
    if config.debug then
        vim.notify("[DEBUG] " .. msg, vim.log.levels.INFO)
    end
end

-- ============================================
-- Plugin Management
-- ============================================

--- Conditionally load a plugin based on a feature flag
--- Used in lazy.nvim plugin specs to enable/disable plugins via config.lua
--- @param is_enabled boolean Whether the plugin should be loaded
--- @param plugin_spec table The lazy.nvim plugin specification
--- @return table|nil The plugin spec if enabled, nil otherwise
--- @usage utils.conditional(config.enable_copilot, { "github/copilot.vim" })
function M.conditional(is_enabled, plugin_spec)
    if is_enabled then
        return plugin_spec
    else
        return nil
    end
end

-- ============================================
-- Command Execution
-- ============================================

--- Execute a Neovim command (wrapper around vim.cmd)
--- Provides a cleaner interface for executing Ex commands
--- @param command string The Ex command to execute (without leading colon)
--- @usage utils.cmd("write")
function M.cmd(command)
    vim.cmd(command)
end

-- ============================================
-- System Utilities
-- ============================================

--- Check if an executable exists in the system PATH
--- Useful for conditionally enabling features based on available tools
--- @param bin string The executable name to check (e.g., "terraform", "kubectl")
--- @return boolean True if executable exists and is in PATH
--- @usage if utils.executable("terraform") then enable_terraform_tools() end
function M.executable(bin)
    return vim.fn.executable(bin) == 1
end

-- ============================================
-- Keymap Helpers
-- ============================================

--- Create a keymap with sensible defaults
--- Wrapper around vim.keymap.set with noremap and silent enabled by default
--- @param mode string|table The mode(s) for the keymap (e.g., "n", "v", {"n", "v"})
--- @param lhs string The key combination to bind
--- @param rhs string|function The command or function to execute
--- @param opts table|nil Optional keymap options (merged with defaults)
--- @usage utils.map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
function M.map(mode, lhs, rhs, opts)
    local options = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, options)
end

return M
