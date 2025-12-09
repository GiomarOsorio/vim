-- ============================================
-- LSP: dockerls (Dockerfile Language Server)
-- ============================================
-- Language server for Dockerfile with syntax validation and completion.
-- Helps write Dockerfiles with best practices and proper syntax.
--
-- Features:
--   - Dockerfile instruction completion
--   - Syntax validation and error detection
--   - Hover documentation for Dockerfile commands
--   - Multi-line instruction support
--   - Best practices suggestions
--
-- Server: dockerfile-language-server (Microsoft)
-- Install: :MasonInstall dockerfile-language-server
--
-- Supported File Patterns:
--   - Dockerfile, Dockerfile.*, *.dockerfile
--   - Auto-detection in projects with docker-compose files

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.dockerls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		docker = {
			languageserver = {
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
	-- Recognize more Dockerfile patterns
	filetypes = { "dockerfile" },
	root_dir = lspconfig.util.root_pattern(
		"Dockerfile",
		"Dockerfile.*",
		"*.dockerfile",
		"docker-compose.yml",
		"docker-compose.yaml",
		".git"
	),
}))
