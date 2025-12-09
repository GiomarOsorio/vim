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
