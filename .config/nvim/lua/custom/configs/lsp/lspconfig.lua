local configs = require("plugins.configs.lspconfig")
local options = {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities
}

local lspconfig = require "lspconfig"
local servers = { "bashls", "docker_compose_language_service", "dockerls", "eslint", "gopls", "jedi_language_server", "marksman", "terraformls", "tsserver", "yamlls"}
for _, lsp in ipairs(servers) do
  local option={}
  if lsp == "bashls" then
    option = require("custom.configs.lsp.settings.bashls")
  end
  if lsp == "docker_compose_language_service" then
    option = require("custom.configs.lsp.settings.dockercomposels")
  end
  if lsp == "dockerls" then
	 	option = require("custom.configs.lsp.settings.dockerls")
  end
	if lsp == "eslint" then
	 	option = require("custom.configs.lsp.settings.eslintls")
  end
	if lsp == "gols" then
	 	option = require("custom.configs.lsp.settings.gols")
  end
	if lsp == "jedi_language_server" then
	 	option = require("custom.configs.lsp.settings.jedils")
  end
	if lsp == "marksman" then
	 	option = require("custom.configs.lsp.settings.marksmanls")
  end
	if lsp == "terraformls" then
	 	option = require("custom.configs.lsp.settings.terraformls")
  end
	if lsp == "tsserver" then
	 	option = require("custom.configs.lsp.settings.tsserver")
  end
	if lsp == "yamlls" then
	 	option = require("custom.configs.lsp.settings.yamlls")
  end
  local final_option = vim.tbl_deep_extend("force", option, options)

  lspconfig[lsp].setup(final_option)
end
