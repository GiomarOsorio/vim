-- lsp/servers/gopls.lua
-- LSP server configuration for Go

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.gopls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		gopls = {
			-- Analysis
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			-- Experimental features
			experimentalPostfixCompletions = true,
			-- Hints (inlay hints)
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			-- Format
			gofumpt = true,
			-- Semantics
			semanticTokens = true,
			staticcheck = true,
			-- Codelens
			codelenses = {
				gc_details = true,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			-- Imports
			completeUnimported = true,
			usePlaceholders = true,
			-- Build directives
			directoryFilters = {
				"-.git",
				"-.vscode",
				"-.idea",
				"-.vscode-test",
				"-node_modules",
			},
		},
	},
	-- Additional configuration for Go
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Organize imports on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.organizeImports" } }
				local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
				for _, res in pairs(result or {}) do
					for _, r in pairs(res.result or {}) do
						if r.edit then
							vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
						end
					end
				end
			end,
		})
	end,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
}))
