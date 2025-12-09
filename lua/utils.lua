-- ================================
-- General Utilities
-- ================================

local M = {}

-- Simple log (only if config.debug is enabled)
function M.log(msg)
    local config = require("config")
    if config.debug then
        vim.notify("[DEBUG] " .. msg, vim.log.levels.INFO)
    end
end

-- Helper to load plugins conditionally
function M.conditional(is_enabled, plugin_spec)
    if is_enabled then
        return plugin_spec
    else
        return nil
    end
end

-- Execute Neovim commands easily
function M.cmd(command)
    vim.cmd(command)
end

-- Check if an executable exists in PATH
function M.executable(bin)
    return vim.fn.executable(bin) == 1
end

-- Helper: set keymaps quickly
function M.map(mode, lhs, rhs, opts)
    local options = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, options)
end

return M
