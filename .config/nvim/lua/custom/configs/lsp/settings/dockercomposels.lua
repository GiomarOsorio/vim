local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern

return {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml" },
  root_dir = root_pattern("docker-compose.yaml"),
  single_file_support = true
}
