-- lsp/servers/jsonls.lua
-- LSP server configuration for JSON

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

-- Try to load schemastore
local schemas = {}
local ok, schemastore = pcall(require, "schemastore")
if ok then
	schemas = schemastore.json.schemas()
end

lspconfig.jsonls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		json = {
			schemas = schemas,
			validate = { enable = true },
			format = { enable = true },
		},
	},
	filetypes = { "json", "jsonc" },
	-- Setup with additional schemas if schemastore is not available
	on_new_config = function(new_config)
		-- If schemastore is available, use its schemas
		local schema_ok, schema = pcall(require, "schemastore")
		if schema_ok then
			new_config.settings.json.schemas = new_config.settings.json.schemas or {}
			vim.list_extend(new_config.settings.json.schemas, schema.json.schemas())
		else
			-- Basic schemas if schemastore is not installed
			new_config.settings.json.schemas = new_config.settings.json.schemas or {}
			vim.list_extend(new_config.settings.json.schemas, {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					fileMatch = { ".prettierrc", ".prettierrc.json" },
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					fileMatch = { ".eslintrc", ".eslintrc.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
			})
		end
	end,
}))
