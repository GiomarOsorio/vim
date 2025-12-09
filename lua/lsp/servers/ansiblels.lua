-- ============================================
-- LSP: ansiblels (Ansible Language Server)
-- ============================================
-- Language server for Ansible playbooks, roles, and tasks.
-- Provides validation, completion, and linting for Ansible YAML files.
--
-- Features:
--   - Ansible module completion and documentation
--   - Playbook and role validation
--   - Integration with ansible-lint for best practices
--   - Fully qualified collection name support
--   - Module option aliases and redirects
--   - Automatic Ansible file detection
--
-- Server: ansible-language-server (Red Hat)
-- Install: :MasonInstall ansible-language-server
--
-- External Dependencies:
--   - ansible (required) - pip install ansible
--   - ansible-lint (optional) - pip install ansible-lint
--
-- File Detection:
--   Automatically sets filetype to yaml.ansible for:
--   - Files in playbooks/, roles/, inventory/ directories
--   - Files matching playbook*.yaml, site.yaml, main.yaml patterns

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.ansiblels.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		ansible = {
			-- Ansible executable
			ansible = {
				path = "ansible",
				useFullyQualifiedCollectionNames = true,
			},
			-- Ansible-lint
			ansibleLint = {
				enabled = true,
				path = "ansible-lint",
				arguments = "",
			},
			-- Python
			python = {
				interpreterPath = "python3",
			},
			-- Validation
			validation = {
				enabled = true,
				lint = {
					enabled = true,
				},
			},
			-- Completion
			completion = {
				provideRedirectModules = true,
				provideModuleOptionAliases = true,
			},
		},
	},
	filetypes = { "yaml.ansible" },
	root_dir = lspconfig.util.root_pattern(
		"ansible.cfg",
		".ansible-lint",
		"playbooks",
		"roles",
		"inventory",
		".git"
	),
	-- Automatically detect Ansible files
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end
	end,
	-- Special configuration to detect Ansible files
	single_file_support = true,
}))

-- Auto-detect Ansible files and change filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*/playbooks/*.yml",
		"*/playbooks/*.yaml",
		"*/roles/*/tasks/*.yml",
		"*/roles/*/tasks/*.yaml",
		"*/roles/*/handlers/*.yml",
		"*/roles/*/handlers/*.yaml",
		"*/roles/*/defaults/*.yml",
		"*/roles/*/defaults/*.yaml",
		"*/roles/*/vars/*.yml",
		"*/roles/*/vars/*.yaml",
		"*/roles/*/meta/*.yml",
		"*/roles/*/meta/*.yaml",
		"*/inventory/*.yml",
		"*/inventory/*.yaml",
		"*/group_vars/*.yml",
		"*/group_vars/*.yaml",
		"*/host_vars/*.yml",
		"*/host_vars/*.yaml",
		"playbook*.yml",
		"playbook*.yaml",
		"site.yml",
		"site.yaml",
		"main.yml",
		"main.yaml",
	},
	callback = function()
		vim.bo.filetype = "yaml.ansible"
	end,
})
