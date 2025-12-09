-- lsp/servers/dockerls.lua
-- LSP server configuration for Dockerfile

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.dockerls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
	-- Recognize more Dockerfile patterns
	filetypes = { "dockerfile" },
	root_dir = lspconfig.util.root_pattern(
		"Dockerfile",
		"Dockerfile.*",
		"*.dockerfile",
		"docker-compose.yml",
		"docker-compose.yaml",
		".git"
	),
}))
