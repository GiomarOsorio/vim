-- ============================================
-- LSP: ts_ls (TypeScript Language Server)
-- ============================================
-- Official TypeScript language server from Microsoft.
-- Provides comprehensive TypeScript/JavaScript support with advanced features.
--
-- Features:
--   - TypeScript and JavaScript intellisense
--   - Inlay hints for types and parameters
--   - Auto-import suggestions
--   - Organize imports command
--   - Function signature completion
--   - Support for React (JSX/TSX)
--   - CommonJS diagnostic filtering
--
-- Server: typescript-language-server (Microsoft)
-- Install: :MasonInstall typescript-language-server
--
-- Keymaps (available in TS/JS files):
--   <leader>oi - Organize imports
--   Standard LSP keymaps from plugins/lsp.lua
--
-- Project Detection:
--   Looks for tsconfig.json, jsconfig.json, or package.json

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.ts_ls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		typescript = {
			-- Inlay hints
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			-- Suggestions
			suggest = {
				completeFunctionCalls = true,
			},
			-- Format
			format = {
				indentSize = 2,
				tabSize = 2,
				convertTabsToSpaces = true,
			},
		},
		javascript = {
			-- Inlay hints
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			-- Suggestions
			suggest = {
				completeFunctionCalls = true,
			},
		},
		completions = {
			completeFunctionCalls = true,
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	-- Detect project root
	root_dir = lspconfig.util.root_pattern(
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git"
	),
	-- Additional commands to organize imports
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Command to organize imports
		vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
			vim.lsp.buf.execute_command({
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(bufnr) },
			})
		end, { desc = "Organize Imports" })

		-- Specific keymaps
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "<leader>oi", ":OrganizeImports<CR>", opts)
	end,
	-- Filter diagnostics from generated files
	handlers = {
		["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			if result.diagnostics == nil then
				return
			end

			-- Filter messages from .d.ts files
			local idx = 1
			while idx <= #result.diagnostics do
				if result.diagnostics[idx].message:find("File is a CommonJS") then
					table.remove(result.diagnostics, idx)
				else
					idx = idx + 1
				end
			end

			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
		end,
	},
}))
