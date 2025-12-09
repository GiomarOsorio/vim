-- ============================================
-- Plugin: nvim-lint (Linting Engine)
-- ============================================
-- Asynchronous linting engine that runs linters on save.
-- Complements LSP diagnostics with language-specific linters.
--
-- Features:
--   - Runs linters asynchronously on save
--   - Integrates with Mason-installed linters
--   - Works alongside LSP diagnostics
--   - No performance impact during editing
--
-- Configured Linters:
--   JavaScript/TypeScript - eslint_d (faster ESLint)
--   Python              - ruff (fast Python linter)
--   Shell               - shellcheck (shell script analyzer)
--   YAML                - yamllint (YAML linter)
--   Go                  - golangci-lint (comprehensive Go linter)
--   Terraform           - tflint (Terraform linter)
--
-- Trigger:
--   - Automatically runs on BufWritePost (after saving)
--   - Diagnostics appear in sign column and Trouble
--
-- Note: Works with plugins/conform.lua (formatters) and LSP diagnostics.
--       All three systems complement each other.
--
-- Plugin: nvim-lint
-- Repo: mfussenegger/nvim-lint

return {
	"mfussenegger/nvim-lint",
	event = "BufReadPre",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			python = { "ruff" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
			go = { "golangci-lint" },
			-- Terraform linting (SRE)
			terraform = { "tflint" },
			tf = { "tflint" },
		}

		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
