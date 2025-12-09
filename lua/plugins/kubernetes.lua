-- ==============================================
-- Kubernetes / Enhanced YAML for SRE
-- ==============================================

return {
  "neovim/nvim-lspconfig",
  ft = { "yaml", "helm" },
  config = function()
    -- Enable yamlls if available
    if vim.lsp.config.yamlls then
      vim.lsp.enable("yamlls")
    end

    -- Enhanced K8s and Helm file detection
    vim.filetype.add({
      extension = {
        yaml = "yaml",
        yml = "yaml",
      },
      pattern = {
        -- kubectl configuration files
        [".*/.kube/config"] = "yaml",

        -- Common Kubernetes files
        [".*deployment.*%.yaml"] = "yaml",
        [".*deployment.*%.yml"] = "yaml",
        [".*service.*%.yaml"] = "yaml",
        [".*service.*%.yml"] = "yaml",
        [".*configmap.*%.yaml"] = "yaml",
        [".*secret.*%.yaml"] = "yaml",
        [".*ingress.*%.yaml"] = "yaml",
        [".*namespace.*%.yaml"] = "yaml",
        [".*pod.*%.yaml"] = "yaml",
        [".*statefulset.*%.yaml"] = "yaml",
        [".*daemonset.*%.yaml"] = "yaml",
        [".*cronjob.*%.yaml"] = "yaml",
        [".*job.*%.yaml"] = "yaml",
        [".*pvc.*%.yaml"] = "yaml",
        [".*pv.*%.yaml"] = "yaml",
        [".*role.*%.yaml"] = "yaml",
        [".*rolebinding.*%.yaml"] = "yaml",
        [".*clusterrole.*%.yaml"] = "yaml",
        [".*networkpolicy.*%.yaml"] = "yaml",
        [".*hpa.*%.yaml"] = "yaml",

        -- Helm charts
        [".*templates/.*%.yaml"] = "helm",
        [".*templates/.*%.yml"] = "helm",
        [".*templates/.*%.tpl"] = "helm",
      },
    })
  end,
}
