-- ============================================
-- Plugin: Kubernetes & Helm Support
-- ============================================
-- Enhanced filetype detection for Kubernetes manifests and Helm charts.
-- Ensures YAML LSP properly recognizes K8s-specific files for validation.
--
-- Features:
--   - Auto-detection of Kubernetes manifest files
--   - Helm chart template recognition
--   - kubectl config file detection
--   - Proper filetype assignment for LSP integration
--
-- Detected Kubernetes Files:
--   - Common K8s resources: deployment, service, configmap, secret,
--     ingress, pod, statefulset, daemonset, cronjob, job, pvc, pv
--   - RBAC: role, rolebinding, clusterrole, networkpolicy
--   - HPA (Horizontal Pod Autoscaler) files
--   - kubectl config (~/.kube/config)
--
-- Helm Template Detection:
--   - Files in templates/ directories (*.yaml, *.yml, *.tpl)
--   - Sets filetype to 'helm' for Helm-specific features
--
-- Integration:
--   - Works with lsp/servers/yamlls.lua which provides:
--     - Kubernetes schema validation
--     - Auto-completion for K8s resources
--     - Hover documentation
--   - Integrates with treesitter for syntax highlighting
--
-- Note: This is a filetype detection plugin, not a full K8s plugin.
--       For kubectl integration, consider external tools like k9s or kubectl CLI.
--
-- Plugin: nvim-lspconfig (used for configuration only)
-- Repo: neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  ft = { "yaml", "helm" },
  config = function()
    -- Enable yamlls for YAML files
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
