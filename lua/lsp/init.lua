-- ============================================
-- LSP Configuration Loader
-- ============================================
-- Automatically discovers and loads all LSP servers installed via Mason.
-- Server-specific configurations are loaded from lua/lsp/servers/<server_name>.lua
-- If no custom config exists, a default configuration is applied.
--
-- Architecture:
--   1. Gets list of installed servers from Mason
--   2. For each server, checks if lua/lsp/servers/<server>.lua exists
--   3. Loads custom config if found, otherwise uses default_config
--   4. All servers inherit capabilities (autocompletion) and on_attach (keybindings)
--
-- Adding a new LSP server:
--   1. Install via Mason: :MasonInstall <server-name>
--   2. (Optional) Create lua/lsp/servers/<server-name>.lua for custom settings
--   3. Restart Neovim - server will be automatically configured

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
