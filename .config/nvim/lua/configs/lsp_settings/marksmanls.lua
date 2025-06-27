local lspconfig = require "lspconfig"
local root_pattern = lspconfig.util.root_pattern

return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_dir = root_pattern(".git", ".marksman.toml"),
  single_file_support = false
}
