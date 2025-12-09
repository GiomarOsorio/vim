-- lsp/servers/yamlls.lua
-- LSP server configuration for YAML
-- Includes schemas for Kubernetes, Docker Compose, GitHub Actions, etc.

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.yamlls.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		yaml = {
			keyOrdering = false,
			format = {
				enable = true,
				singleQuote = false,
				bracketSpacing = true,
			},
			validate = true,
			hover = true,
			completion = true,
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemas = {
				-- Kubernetes
				kubernetes = {
					"*.k8s.yaml",
					"*.k8s.yml",
					"**/kubernetes/**/*.yaml",
					"**/kubernetes/**/*.yml",
					"**/k8s/**/*.yaml",
					"**/k8s/**/*.yml",
					"**/manifests/**/*.yaml",
					"**/manifests/**/*.yml",
					"deployment*.yaml",
					"deployment*.yml",
					"service*.yaml",
					"service*.yml",
					"configmap*.yaml",
					"configmap*.yml",
					"secret*.yaml",
					"secret*.yml",
					"ingress*.yaml",
					"ingress*.yml",
					"pod*.yaml",
					"pod*.yml",
					"statefulset*.yaml",
					"statefulset*.yml",
					"daemonset*.yaml",
					"daemonset*.yml",
					"cronjob*.yaml",
					"cronjob*.yml",
					"job*.yaml",
					"job*.yml",
					"pvc*.yaml",
					"pvc*.yml",
					"pv*.yaml",
					"pv*.yml",
					"namespace*.yaml",
					"namespace*.yml",
					"rbac*.yaml",
					"rbac*.yml",
					"role*.yaml",
					"role*.yml",
					"clusterrole*.yaml",
					"clusterrole*.yml",
					"serviceaccount*.yaml",
					"serviceaccount*.yml",
					"networkpolicy*.yaml",
					"networkpolicy*.yml",
					"hpa*.yaml",
					"hpa*.yml",
				},
				-- Helm Chart.yaml
				["https://json.schemastore.org/chart.json"] = {
					"Chart.yaml",
					"Chart.yml",
				},
				-- Helm values
				["https://json.schemastore.org/helmfile.json"] = {
					"helmfile.yaml",
					"helmfile.yml",
				},
				-- Docker Compose
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
					"docker-compose*.yaml",
					"docker-compose*.yml",
					"compose*.yaml",
					"compose*.yml",
				},
				-- GitHub Actions
				["https://json.schemastore.org/github-workflow.json"] = {
					".github/workflows/*.yaml",
					".github/workflows/*.yml",
				},
				-- GitHub Actions (action.yml)
				["https://json.schemastore.org/github-action.json"] = {
					"action.yaml",
					"action.yml",
				},
				-- GitLab CI
				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
					".gitlab-ci.yml",
					".gitlab-ci.yaml",
				},
				-- Azure Pipelines
				["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
					"azure-pipelines*.yaml",
					"azure-pipelines*.yml",
				},
				-- Ansible
				["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
					"**/playbooks/**/*.yaml",
					"**/playbooks/**/*.yml",
					"playbook*.yaml",
					"playbook*.yml",
					"site.yaml",
					"site.yml",
				},
				-- Kustomization
				["https://json.schemastore.org/kustomization.json"] = {
					"kustomization.yaml",
					"kustomization.yml",
				},
				-- Dependabot
				["https://json.schemastore.org/dependabot-2.0.json"] = {
					".github/dependabot.yaml",
					".github/dependabot.yml",
				},
				-- Pre-commit
				["https://json.schemastore.org/pre-commit-config.json"] = {
					".pre-commit-config.yaml",
					".pre-commit-config.yml",
				},
				-- Renovate
				["https://docs.renovatebot.com/renovate-schema.json"] = {
					"renovate.json",
					"renovate.json5",
					".renovaterc",
					".renovaterc.json",
				},
				-- ArgoCD Application
				["https://raw.githubusercontent.com/argoproj/argo-cd/master/pkg/apis/application/v1alpha1/types.go"] = {
					"**/argocd/**/*.yaml",
					"**/argocd/**/*.yml",
				},
			},
		},
	},
	-- Exclude Helm values.yaml from kubernetes schema
	on_attach = function(client, bufnr)
		-- Call global on_attach first
		if default.on_attach then
			default.on_attach(client, bufnr)
		end

		-- Detect if it's a Helm values file and disable kubernetes schema
		local filename = vim.fn.expand("%:t")
		if filename:match("values") then
			client.config.settings.yaml.schemas.kubernetes = nil
		end
	end,
}))
