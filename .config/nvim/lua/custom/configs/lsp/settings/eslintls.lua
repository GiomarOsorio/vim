vim.cmd [[autocmd BufWritePre *.jsx,*.js,*tsx,*ts EslintFixAll]]

return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "vue", "typescript", "typescriptreact", "typescript.tsx",
  },
  -- Eslint options -> "https://github.com/rcjsuen/dockerfile-language-server-nodejs#language-server-settings"
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all"
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
    },
  },
}
