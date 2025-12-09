-- lsp/servers/marksman.lua
-- LSP server configuration for Markdown

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.marksman.setup(vim.tbl_deep_extend("force", default, {
	filetypes = { "markdown", "markdown.mdx" },
	root_dir = lspconfig.util.root_pattern(
		".marksman.toml",
		".git"
	),
	-- Additional configuration for documentation
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Markdown-specific keymaps
		local opts = { buffer = bufnr, silent = true }

		-- Preview markdown (if you have a preview plugin)
		vim.keymap.set("n", "<leader>mp", function()
			-- Try to use markdown-preview if available
			local ok = pcall(vim.cmd, "MarkdownPreview")
			if not ok then
				vim.notify("Preview plugin not installed", vim.log.levels.INFO)
			end
		end, opts)

		-- Toggle checkbox in task lists
		vim.keymap.set("n", "<leader>mt", function()
			local line = vim.api.nvim_get_current_line()
			if line:match("%[ %]") then
				line = line:gsub("%[ %]", "[x]", 1)
			elseif line:match("%[x%]") then
				line = line:gsub("%[x%]", "[ ]", 1)
			end
			vim.api.nvim_set_current_line(line)
		end, opts)
	end,
}))
