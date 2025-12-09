-- mason.lua
-- Unified configuration for:
-- - mason.nvim
-- - mason-lspconfig
-- - mason-tool-installer
--
-- Cleaned up duplicates, incorrect names,
-- and used only official tool names.

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},

		-- Allows extending ensure_installed from other configs if needed
		opts_extend = { "ensure_installed" },

		---------------------------------------------------------------------
		-- Final list (LSP + tools + formatters + linters + DAP)
		-- This list contains EVERYTHING Mason should install,
		-- using correct names and removing duplicates.
		---------------------------------------------------------------------
		opts = {
			ensure_installed = {

				-----------------------------------------------------------------
				-- LSP SERVERS (no duplicates)
				-----------------------------------------------------------------
				"ansiblels",
				"bashls",
				"dockerls",
				"eslint",
				"gopls",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"pyright",
				"terraformls",
				"tflint",
				"ts_ls",
				"yamlls",

				-----------------------------------------------------------------
				-- FORMATTERS / LINTERS / EXTERNAL TOOLS
				-----------------------------------------------------------------
				"black",
				"eslint_d",
				"prettier",
				"shellcheck",
				"shfmt",
				"ruff", -- CLI, NOT LSP
				"stylua",
				"yamllint",
				-- Go tools
				"gofumpt",
				"goimports",
				"golangci-lint",

				-----------------------------------------------------------------
				-- DEBUG ADAPTERS
				-----------------------------------------------------------------
				"js-debug-adapter",
			},
		},

		config = function(_, opts)
			-----------------------------------------------------
			-- Mason base
			-----------------------------------------------------
			require("mason").setup()

			-----------------------------------------------------
			-- Automatic tool installation (non-LSP)
			-----------------------------------------------------
			local tool_installer = require("mason-tool-installer")

			tool_installer.setup({
				ensure_installed = opts.ensure_installed,
				auto_update = true,
				run_on_start = true,
			})

			-----------------------------------------------------
			-- mason-lspconfig (LSP servers only)
			--
			-- This is the definitive and correct list,
			-- using only official LSP names.
			-----------------------------------------------------
			require("mason-lspconfig").setup({

				ensure_installed = {
					"bashls",
					"dockerls",
					"eslint",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"marksman",
					"pyright",
					"terraformls",
					"tflint",
					"ts_ls",
					"yamlls",
				},

				automatic_installation = true,
				auto_update = true,
				run_on_start = true,

				handlers = {
					-- Default handler for any detected LSP
					function(server)
						local lspconfig = require("lspconfig")
						lspconfig[server].setup({})
					end,
				},
			})

			-----------------------------------------------------
			-- FileType trigger when Mason installs something
			--
			-- This forces loading of newly installed LSP
			-- without needing to restart Neovim.
			-----------------------------------------------------
			local registry = require("mason-registry")
			registry:on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
		end,
	},
}
