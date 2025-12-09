-- ============================================
-- Plugin: Conform (Code Formatting)
-- ============================================
-- Fast and modern code formatter that runs formatters on save.
-- Supports multiple formatters per filetype with proper chaining.
--
-- Features:
--   - Automatic formatting on save
--   - Multiple formatters per language (run in sequence)
--   - Fast async formatting
--   - Integrates with Mason-installed formatters
--
-- Configured Formatters:
--   Lua         - stylua
--   JS/TS       - prettierd (faster than prettier)
--   JSON/YAML   - prettier
--   HTML        - prettier
--   Python      - black + isort (format + import sorting)
--   Shell       - shfmt
--   Go          - gofumpt + goimports (strict format + imports)
--
-- Manual Format:
--   <leader>f - Format current file (defined in core/keymaps.lua)
--
-- Note: Some LSP servers also provide formatting (e.g., terraformls).
--       Conform takes priority when configured for a filetype.
--
-- Plugin: conform.nvim
-- Repo: stevearc/conform.nvim

return {
	"stevearc/conform.nvim",
	event = "BufWritePre", -- Load before saving
	config = function()
		require("conform").setup({
			format_on_save = true,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				json = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },
				python = { "black", "isort" }, -- Run both in sequence
				sh = { "shfmt" },
				go = { "gofumpt", "goimports" }, -- Format then organize imports
			},
		})
	end,
}
