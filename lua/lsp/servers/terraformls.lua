-- ============================================
-- LSP: terraformls (Terraform Language Server)
-- ============================================
-- Official HashiCorp Terraform language server for infrastructure-as-code.
-- Provides validation, completion, and formatting for Terraform files.
--
-- Features:
--   - Terraform syntax validation
--   - Resource/data source completion
--   - Automatic formatting on save (terraform fmt)
--   - Prefill required fields in resources
--   - Module and provider documentation
--
-- Server: terraform-ls (HashiCorp)
-- Install: :MasonInstall terraform-ls
--
-- Keymaps (available in Terraform files):
--   <leader>ti - Run terraform init
--   <leader>tv - Run terraform validate
--   <leader>tp - Run terraform plan
--   <leader>ta - Run terraform apply
--   Standard LSP keymaps from plugins/lsp.lua

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.terraformls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		terraform = {
			-- Enable automatic formatting
			formatting = {
				enable = true,
			},
		},
		["terraform-ls"] = {
			-- Experimental features
			experimentalFeatures = {
				validateOnSave = true,        -- Validate on save
				prefillRequiredFields = true, -- Auto-fill required resource fields
			},
		},
	},
	-- Supported file types
	filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
	-- Project root detection
	root_dir = lspconfig.util.root_pattern(
		".terraform",        -- Terraform working directory
		".git",             -- Git repository
		"*.tf",             -- Any Terraform file
		"terraform.tfstate" -- Terraform state file
	),
	-- Custom on_attach for Terraform-specific features
	on_attach = function(client, bufnr)
		-- Call global on_attach first (LSP keymaps)
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Auto-format on save (terraform fmt)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- Terraform CLI keymaps (buffer-local)
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "<leader>ti", ":!terraform init<CR>", opts)
		vim.keymap.set("n", "<leader>tv", ":!terraform validate<CR>", opts)
		vim.keymap.set("n", "<leader>tp", ":!terraform plan<CR>", opts)
		vim.keymap.set("n", "<leader>ta", ":!terraform apply<CR>", opts)
	end,
}))
