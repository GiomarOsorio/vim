local lspconfig = require "lspconfig"
local util = lspconfig.util

return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  root_dir = util.find_git_ancestor,
  settings = {
    redhat = {
      telemetry = {
        enabled = false
      }
    },
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
      },
    },
  },
  single_file_support = true
}
