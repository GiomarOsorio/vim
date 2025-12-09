-- ================================
-- Global User Configuration
-- ================================

local M = {}

-- ======================================
-- CONDITIONAL PLUGINS FLAGS
-- ======================================

-- Enable/disable GitHub Copilot
M.enable_copilot = false

-- Enable/disable Claude Code AI assistant
M.enable_claudecode = false

-- Enable/disable Dashboard on startup
M.enable_dashboard = true

-- Default colorscheme
M.colorscheme = "grubvox"

-- General debugging option
M.debug = false

-- Future specific options can be added here:
-- M.enable_kubernetes_tools = true
-- M.enable_terraform_tools = true

return M
