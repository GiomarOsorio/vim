-- lsp/servers/lua_ls.lua
-- LSP server configuration for Lua

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "require" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}))
