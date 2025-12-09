-- ============================================
-- LSP: html (HTML Language Server)
-- ============================================
-- VSCode's HTML language server with formatting and validation.
-- Supports HTML5, embedded CSS/JavaScript, and template languages.
--
-- Features:
--   - HTML5 tag completion and validation
--   - Embedded CSS and JavaScript support
--   - Hover documentation for HTML elements
--   - Formatting with configurable options
--   - Support for Django templates and Templ
--   - Emmet abbreviation support
--
-- Server: vscode-html-language-server (Microsoft)
-- Install: :MasonInstall html-lsp

local lspconfig = require("lspconfig")
local default = _G.LSP_DEFAULT_CONFIG or {}

lspconfig.html.setup(vim.tbl_deep_extend("force", default, {
	settings = {
		html = {
			format = {
				enable = true,
				wrapLineLength = 120,
				unformatted = "wbr",
				contentUnformatted = "pre,code,textarea",
				indentInnerHtml = false,
				preserveNewLines = true,
				maxPreserveNewLines = nil,
				indentHandlebars = false,
				endWithNewline = false,
				extraLiners = "head, body, /html",
				wrapAttributes = "auto",
			},
			hover = {
				documentation = true,
				references = true,
			},
			suggest = {
				html5 = true,
			},
			validate = {
				scripts = true,
				styles = true,
			},
		},
	},
	filetypes = { "html", "htmldjango", "templ" },
	-- Initialization with optional Emmet
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
}))
