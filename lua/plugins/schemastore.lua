-- ============================================
-- Plugin: Schemastore (JSON/YAML Schemas)
-- ============================================
-- Provides 500+ JSON and YAML schemas for LSP validation and completion.
-- Automatically integrated with jsonls and yamlls language servers.
--
-- Features:
--   - 500+ pre-configured schemas from SchemaStore.org
--   - Automatic schema detection by filename
--   - Enhanced completion for config files
--   - Validation for common JSON/YAML files
--
-- Supported Files (examples):
--   - package.json, tsconfig.json
--   - .eslintrc, .prettierrc
--   - docker-compose.yml
--   - GitHub Actions workflows
--   - Kubernetes manifests
--   - And 500+ more...
--
-- Integration:
--   - Used by lsp/servers/jsonls.lua
--   - Used by lsp/servers/yamlls.lua (via yamlls config)
--   - Loaded lazily when needed by LSP servers
--
-- No manual configuration needed - schemas are automatically applied
-- when you open supported files.
--
-- Plugin: schemastore.nvim
-- Repo: b0o/schemastore.nvim

return {
	"b0o/schemastore.nvim",
	lazy = true, -- Lazy loaded when jsonls or yamlls need it
}
