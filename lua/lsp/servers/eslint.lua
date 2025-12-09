-- ============================================
-- LSP: eslint (ESLint Language Server)
-- ============================================
-- ESLint language server for JavaScript/TypeScript linting and formatting.
-- Provides real-time linting and automatic fixes on save.
--
-- Features:
--   - Real-time ESLint diagnostics (as you type)
--   - Auto-fix on save (formatting + lint fixes)
--   - Code actions to disable rules
--   - Documentation links for ESLint rules
--   - Support for JS, TS, Vue, Svelte, Astro
--   - Auto-detection of ESLint config files
--
-- Server: vscode-eslint-language-server (Microsoft)
-- Install: :MasonInstall eslint-lsp
--
-- External Dependency:
--   - ESLint must be installed in project: npm install -D eslint
--   - ESLint config file (.eslintrc, eslint.config.js, etc.)
--
-- Note: Works with plugins/conform.lua and core/autocmds.lua
--       for automatic fixing on save

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.eslint.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		workingDirectories = { mode = "auto" },
		format = true,
		quiet = false,
		onIgnoredFiles = "off",
		rulesCustomizations = {},
		run = "onType",
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
	},
	-- Auto-fix on save
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Auto-fix ESLint on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
	},
}))
