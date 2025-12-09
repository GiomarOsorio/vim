-- ==============================================
-- Treesitter Configuration
-- ==============================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },

	config = function()
		require("nvim-treesitter.configs").setup({

			-- Languages to install
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",

				-- Backend
				"javascript",
				"typescript",
				"tsx",
				"json",
				"json5",
				"jsonc",
				"jsonnet",
				"jsdoc",

				-- SRE / infra
				"yaml",
				"dockerfile",
				"terraform",
				"bash",
				"go",
				"cmake",
				"jq",
				"xml",
				"requirements",
				"gpg",

				-- Git
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",

				-- Other useful
				"python",
				"markdown",
				"markdown_inline",
				"query",
				"hcl",
				"toml",
				"ini",
				"regex",
				"comment",
				"css",
				"csv",
			},

			-- Enhancements
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
				},
			},

			-- Better TS-based folding
			fold = {
				enable = true,
			},
		})

		-- Configure Treesitter-based folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99 -- Open all by default
	end,
}
