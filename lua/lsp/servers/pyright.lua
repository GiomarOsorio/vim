-- ============================================
-- LSP: pyright (Python Language Server)
-- ============================================
-- Microsoft's Python type checker and language server.
-- Provides fast type checking, auto-completion, and code navigation.
--
-- Features:
--   - Type checking (configurable strictness)
--   - Automatic virtual environment detection
--   - Auto-import completions
--   - Workspace-wide diagnostics
--   - Library type stubs support
--
-- Server: pyright (Microsoft)
-- Install: :MasonInstall pyright
--
-- Virtual Environment Detection:
--   Automatically searches for: .venv, venv, .env, env (in order)
--   No manual configuration needed for most Python projects

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.pyright.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",       -- Type checking: "off", "basic", or "strict"
				autoSearchPaths = true,           -- Automatically search for import paths
				useLibraryCodeForTypes = true,    -- Use library code for type information
				diagnosticMode = "workspace",     -- Check entire workspace, not just open files
				autoImportCompletions = true,     -- Suggest imports in completions
			},
		},
	},
	-- Automatically detect and use virtual environments
	before_init = function(_, config)
		local path = vim.fn.getcwd()
		-- Search for virtual environment in priority order
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
