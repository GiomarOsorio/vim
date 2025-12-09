-- ============================================
-- LSP: lua_ls (Lua Language Server)
-- ============================================
-- Provides Lua language support with Neovim-specific enhancements.
-- Configured for optimal Neovim plugin/config development.
--
-- Features:
--   - Recognizes 'vim' global and Neovim API
--   - Loads Neovim runtime files for completion
--   - Disables third-party library prompts
--   - Uses LuaJIT runtime (Neovim's Lua version)
--   - Telemetry disabled for privacy
--
-- Server: lua-language-server (sumneko)
-- Install: :MasonInstall lua-language-server

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		Lua = {
			-- Runtime configuration
			runtime = {
				version = "LuaJIT", -- Neovim uses LuaJIT
			},
			-- Diagnostics: recognize Neovim globals
			diagnostics = {
				globals = { "vim", "require" },
			},
			-- Workspace: load Neovim runtime for completion
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Don't ask about third-party libraries
			},
			-- Privacy: disable telemetry
			telemetry = {
				enable = false,
			},
			-- Completion: replace function calls instead of inserting
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}))
