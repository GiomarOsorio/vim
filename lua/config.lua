-- ================================
-- Global User Configuration
-- ================================
-- This file contains all user-configurable options for the Neovim setup.
-- Modify these values to customize your environment without touching plugin code.

local M = {}

-- ======================================
-- CONDITIONAL PLUGINS FLAGS
-- ======================================
-- These flags control which optional plugins are loaded at startup.
-- Changing these values requires a Neovim restart to take effect.

-- GitHub Copilot Integration
-- Set to true to enable GitHub Copilot AI code suggestions
-- After enabling, run :Copilot auth to authenticate
-- Requires: Node.js and GitHub Copilot subscription
M.enable_copilot = false

-- Claude Code AI Assistant
-- Set to true to enable Claude Code integration
-- Provides AI-powered code completion and assistance
-- Requires: Claude Code CLI installed and configured
M.enable_claudecode = false

-- Dashboard on Startup
-- Set to true to show the TurtleSRE dashboard when starting Neovim
-- Set to false to start with an empty buffer
-- The dashboard provides quick access to files, recent files, and shortcuts
M.enable_dashboard = true

-- ======================================
-- APPEARANCE
-- ======================================

-- Default Colorscheme
-- Current: "gruvbox" - warm, comfortable color scheme
-- To change: replace with any installed colorscheme name
-- Examples: "catppuccin", "tokyonight", "nord", "onedark"
M.colorscheme = "gruvbox"

-- ======================================
-- DEBUGGING
-- ======================================

-- General Debug Mode
-- Set to true to enable verbose logging and debug information
-- Useful for troubleshooting configuration issues
-- Warning: May impact performance when enabled
M.debug = false

-- ======================================
-- FUTURE EXPANSION
-- ======================================
-- Placeholder for additional configuration options:
--
-- SRE/DevOps Tool Toggles:
-- M.enable_kubernetes_tools = true    -- K8s-specific plugins and keymaps
-- M.enable_terraform_tools = true     -- Terraform-specific tools
-- M.enable_docker_tools = true        -- Docker-specific integrations
--
-- Development Features:
-- M.enable_test_integration = true    -- Testing framework integration
-- M.enable_database_tools = false     -- Database client plugins
--
-- UI Customization:
-- M.transparent_background = false    -- Transparent terminal background
-- M.font_size = 12                    -- Terminal font size (if supported)
--
-- Add your custom flags here following the same pattern

return M
