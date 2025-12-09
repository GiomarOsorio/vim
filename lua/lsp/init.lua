-- lsp/init.lua
-- Automatic loading of LSP server configurations
-- Each server can have its own file in lua/lsp/servers/

local lspconfig = require("lspconfig")

-- Get capabilities and on_attach from central module
local lsp_config = require("plugins.lsp")
local capabilities = lsp_config.capabilities or require("cmp_nvim_lsp").default_capabilities()
local on_attach = lsp_config.on_attach

-- Path where custom configurations are stored
local configs_path = vim.fn.stdpath("config") .. "/lua/lsp/servers"

-- Helper to check if a file exists
local function file_exists(path)
	return vim.fn.filereadable(path) == 1
end

-- Base configuration inherited by all servers
local default_config = {
	capabilities = capabilities,
	on_attach = on_attach,
}

-- Expose base configuration for servers to use
_G.LSP_DEFAULT_CONFIG = default_config

-- Get list of servers installed by Mason
local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	vim.notify("mason-lspconfig is not installed", vim.log.levels.WARN)
	return
end

-- Iterate over each installed server
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
	local cfg_file = configs_path .. "/" .. server_name .. ".lua"

	if file_exists(cfg_file) then
		-- Load custom configuration
		local success, err = pcall(require, "lsp.servers." .. server_name)
		if not success then
			vim.notify("Error loading LSP " .. server_name .. ": " .. err, vim.log.levels.ERROR)
		end
	else
		-- Use default configuration
		lspconfig[server_name].setup(default_config)
	end
end
