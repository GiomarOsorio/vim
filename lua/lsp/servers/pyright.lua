-- lsp/servers/pyright.lua
-- LSP server configuration for Python

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.pyright.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				autoImportCompletions = true,
			},
		},
	},
	-- Automatically detect virtual environments
	before_init = function(_, config)
		local path = vim.fn.getcwd()
		-- Search venv in priority order
		local venvs = { ".venv", "venv", ".env", "env" }
		for _, venv in ipairs(venvs) do
			local venv_path = path .. "/" .. venv
			if vim.fn.isdirectory(venv_path) == 1 then
				config.settings.python.pythonPath = venv_path .. "/bin/python"
				break
			end
		end
	end,
}))
