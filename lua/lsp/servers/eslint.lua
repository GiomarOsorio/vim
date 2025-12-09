-- lsp/servers/eslint.lua
-- LSP server configuration for ESLint

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
