return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
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
				python = { "black", "isort" },
				sh = { "shfmt" },
				go = { "gofumpt", "goimports" },
			},
		})
	end,
}
