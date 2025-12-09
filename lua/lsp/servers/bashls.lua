-- lsp/servers/bashls.lua
-- LSP server configuration for Bash/Shell

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.bashls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		bashIde = {
			-- Enable glob expansion
			globPattern = "*@(.sh|.inc|.bash|.command)",
			-- Include integrated shellcheck linting
			includeAllWorkspaceSymbols = true,
			-- Script analysis
			shellcheckPath = "shellcheck",
			shellcheckArguments = {},
		},
	},
	filetypes = { "sh", "bash", "zsh" },
	-- Detect root in projects with scripts
	root_dir = lspconfig.util.root_pattern(
		".git",
		".bashrc",
		".bash_profile",
		".zshrc",
		"Makefile"
	),
}))
