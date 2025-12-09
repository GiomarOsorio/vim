-- ============================================
-- LSP: gopls (Go Language Server)
-- ============================================
-- Official Go language server with comprehensive analysis and tooling.
-- Optimized for backend/SRE Go development with advanced features enabled.
--
-- Features:
--   - Static analysis (staticcheck, nilness, shadow variables)
--   - Inlay hints for types and parameters
--   - Automatic import organization on save
--   - gofumpt formatting (stricter than gofmt)
--   - Code lenses (tests, generate, govulncheck, tidy)
--   - Semantic tokens for better syntax highlighting
--
-- Server: gopls (official Google Go team)
-- Install: :MasonInstall gopls
--
-- Keymaps (available in Go files):
--   - Standard LSP keymaps from plugins/lsp.lua

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.gopls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		gopls = {
			-- Static analysis features
			analyses = {
				unusedparams = true,  -- Detect unused function parameters
				shadow = true,        -- Detect shadowed variables
				nilness = true,       -- Detect potential nil dereferences
				unusedwrite = true,   -- Detect unused writes
				useany = true,        -- Suggest using 'any' over 'interface{}'
			},
			-- Experimental postfix completions (e.g., ".for", ".if")
			experimentalPostfixCompletions = true,
			-- Inlay hints (inline type information)
			hints = {
				assignVariableTypes = true,        -- Show types in := assignments
				compositeLiteralFields = true,     -- Show field names in literals
				compositeLiteralTypes = true,      -- Show types in composite literals
				constantValues = true,             -- Show constant values
				functionTypeParameters = true,     -- Show generic type parameters
				parameterNames = true,             -- Show parameter names in calls
				rangeVariableTypes = true,         -- Show types in range loops
			},
			-- Use gofumpt (stricter Go formatter)
			gofumpt = true,
			-- Enable semantic tokens (better syntax highlighting)
			semanticTokens = true,
			-- Enable staticcheck integration
			staticcheck = true,
			-- Code lenses (clickable actions in editor)
			codelenses = {
				gc_details = true,          -- Show garbage collector details
				generate = true,            -- Run go generate
				regenerate_cgo = true,      -- Regenerate cgo bindings
				run_govulncheck = true,     -- Check for vulnerabilities
				test = true,                -- Run tests
				tidy = true,                -- Run go mod tidy
				upgrade_dependency = true,  -- Upgrade dependencies
				vendor = true,              -- Vendor dependencies
			},
			-- Import behavior
			completeUnimported = true,  -- Suggest unimported packages
			usePlaceholders = true,     -- Use placeholders in completions
			-- Exclude directories from indexing
			directoryFilters = {
				"-.git",
				"-.vscode",
				"-.idea",
				"-.vscode-test",
				"-node_modules",
			},
		},
	},
	-- Custom on_attach for Go-specific features
	on_attach = function(client, bufnr)
		-- Call global on_attach first (LSP keymaps)
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Auto-organize imports on save
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
	-- Supported file types
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
}))
