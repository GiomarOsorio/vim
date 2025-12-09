-- ============================================
-- LSP: bashls (Bash Language Server)
-- ============================================
-- Language server for Bash/Shell scripts with shellcheck integration.
-- Provides linting, completion, and navigation for shell scripts.
--
-- Features:
--   - Syntax checking and linting (via shellcheck)
--   - Code completion for builtins and commands
--   - Hover documentation for commands
--   - Symbol navigation (functions, variables)
--   - Support for sh, bash, and zsh scripts
--
-- Server: bash-language-server
-- Install: :MasonInstall bash-language-server
--
-- External Dependency:
--   - shellcheck (for linting) - install via package manager
--     Ubuntu/Debian: sudo apt install shellcheck
--     macOS: brew install shellcheck

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.bashls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		bashIde = {
			-- Enable glob expansion
			globPattern = "*@(.sh|.inc|.bash|.command)",
			-- Include integrated shellcheck linting
			includeAllWorkspaceSymbols = true,
			-- Script analysis
			shellcheckPath = "shellcheck",
			shellcheckArguments = {},
		},
	},
	filetypes = { "sh", "bash", "zsh" },
	-- Detect root in projects with scripts
	root_dir = lspconfig.util.root_pattern(
		".git",
		".bashrc",
		".bash_profile",
		".zshrc",
		"Makefile"
	),
}))
