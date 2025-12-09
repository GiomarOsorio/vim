-- lsp/servers/terraformls.lua
-- LSP server configuration for Terraform

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.terraformls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		terraform = {
			-- Terraform formatting
			formatting = {
				enable = true,
			},
		},
		["terraform-ls"] = {
			-- Experimental features
			experimentalFeatures = {
				validateOnSave = true,
				prefillRequiredFields = true,
			},
		},
	},
	filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
	root_dir = lspconfig.util.root_pattern(
		".terraform",
		".git",
		"*.tf",
		"terraform.tfstate"
	),
	-- Auto-format on save
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Terraform format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Terraform-specific keymaps
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "<leader>ti", ":!terraform init<CR>", opts)
		vim.keymap.set("n", "<leader>tv", ":!terraform validate<CR>", opts)
		vim.keymap.set("n", "<leader>tp", ":!terraform plan<CR>", opts)
		vim.keymap.set("n", "<leader>ta", ":!terraform apply<CR>", opts)
	end,
}))
