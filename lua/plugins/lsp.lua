-- ============================================
-- Plugin: LSP Configuration
-- ============================================
-- Central LSP configuration that provides shared capabilities and keybindings
-- for all language servers. This module is imported by lua/lsp/init.lua.
--
-- Features:
--   - Unified LSP keybindings for all servers
--   - Shared completion capabilities from nvim-cmp
--   - Diagnostic configuration and icons
--   - Rounded borders for floating windows
--   - Navigate to definition, references, implementation
--   - Code actions, rename, and signature help
--
-- Keymaps (available when LSP is attached):
--   K           - Hover documentation
--   gd          - Go to definition
--   gD          - Go to declaration
--   gr          - Find references
--   gi          - Go to implementation
--   <leader>D   - Type definition
--   <leader>rn  - Rename symbol
--   <leader>ca  - Code actions
--   [d          - Previous diagnostic
--   ]d          - Next diagnostic
--   <leader>dl  - Diagnostics to location list
--   <C-k>       - Signature help (normal and insert mode)
--   <leader>cf  - Format with LSP (fallback)
--
-- Plugin: nvim-lspconfig
-- Repo: neovim/nvim-lspconfig

local M = {}

-- Shared capabilities for all LSP servers
M.capabilities = nil

-- Shared on_attach for all LSP servers
M.on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	local map = vim.keymap.set

	-- Documentation and hover
	map("n", "K", vim.lsp.buf.hover, opts)

	-- Code navigation
	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gr", vim.lsp.buf.references, opts)
	map("n", "gi", vim.lsp.buf.implementation, opts)
	map("n", "<leader>D", vim.lsp.buf.type_definition, opts)

	-- Refactoring
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- Diagnostics - navigation
	map("n", "[d", vim.diagnostic.goto_prev, opts)
	map("n", "]d", vim.diagnostic.goto_next, opts)
	map("n", "<leader>dl", vim.diagnostic.setloclist, opts)

	-- Function signature (useful in Go, Python, etc.)
	map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	map("i", "<C-k>", vim.lsp.buf.signature_help, opts)

	-- Format with LSP (backup if conform is not available)
	map("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- Initialize capabilities with nvim-cmp support
		M.capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Configure global diagnostics
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "if_many",
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Icons for diagnostics in the gutter
		local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Borders for LSP floating windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		-- Load server configurations from lsp/init.lua
		require("lsp")
	end,
}
