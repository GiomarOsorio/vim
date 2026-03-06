-- ============================================
-- Plugin: Treesitter (Syntax Parsing & Highlighting)
-- ============================================
-- Advanced syntax highlighting and code understanding using tree-sitter parsers.
-- Provides better syntax highlighting, indentation, and text objects.
--
-- Features:
--   - Accurate syntax highlighting (better than regex)
--   - Smart code folding based on syntax
--   - Incremental selection (expand/shrink selection by syntax nodes)
--   - Auto-indentation
--   - 40+ language parsers pre-installed
--
-- Installed Languages:
--   - Core: Lua, Vim, Vimdoc, Query
--   - Backend: JavaScript, TypeScript, JSON, Python, Go
--   - SRE/DevOps: YAML, Dockerfile, Terraform, Bash, HCL
--   - Git: git_config, gitcommit, gitignore
--   - Others: Markdown, TOML, CSV, Regex, Requirements
--
-- Keymaps (incremental selection):
--   <CR>    - Init/expand selection to next syntax node
--   <S-CR>  - Expand selection to scope
--   <BS>    - Shrink selection
--
-- Folding:
--   Treesitter-based folding enabled (folds based on syntax structure)
--   All folds open by default (foldlevel=99)
--
-- Plugin: nvim-treesitter
-- Repo: nvim-treesitter/nvim-treesitter

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },

	config = function()
		require("nvim-treesitter").setup({

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

		})

		-- Configure Treesitter-based folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99 -- Open all by default
	end,
}
