require("nvchad.configs.lspconfig").defaults()

local configs = vim.lsp.config
local options = {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities
}

local lspconfig = require "lspconfig"
local servers = { "bashls", "docker_compose_language_service", "dockerls", "eslint", "gopls", "jedi_language_server", "marksman", "terraformls", "tflint", "tsserver", "yamlls"}
vim.lsp.enable(servers)


for _, lsp in ipairs(servers) do
  local option={}
  if lsp == "bashls" then
    option = require("lua.configs.lsp_settings.bashls")
  end
  if lsp == "docker_compose_language_service" then
    option = require("lua.configs.lsp_settings.dockercomposels")
  end
  if lsp == "dockerls" then
	 	option = require("lua.configs.lsp_settings.dockerls")
  end
	if lsp == "eslint" then
	 	option = require("lua.configs.lsp_settings.eslintls")
  end
	if lsp == "gols" then
	 	option = require("lua.configs.lsp_settings.gols")
  end
	if lsp == "jedi_language_server" then
	 	option = require("lua.configs.lsp_settings.jedils")
  end
	if lsp == "marksman" then
	 	option = require("lua.configs.lsp_settings.marksmanls")
  end
	if lsp == "terraformls" then
	 	option = require("lua.configs.lsp_settings.terraformls")
  end
	if lsp == "tsserver" then
	 	option = require("lua.configs.lsp_settings.tsserver")
  end
	if lsp == "yamlls" then
	 	option = require("lua.configs.lsp_settings.yamlls")
  end
  local final_option = vim.tbl_deep_extend("force", option, options)

  lspconfig[lsp].setup(final_option)
end


-- read :h vim.lsp.config for changing options of lsp servers 
