local plugins = {
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require "custom.configs.dap"
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function ()
      require "custom.configs.dap-ui"
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lsp.lspconfig"
      require("core.utils").load_mappings("lsp")
    end
  },
  {
    "tpope/vim-fugitive",
    lazy = false
  },
  {
   "williamboman/mason.nvim",
   opts = {
    -- init Custom LSP
      ensure_installed = {
        "bash-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "gopls",
        "jedi-language-server",
        "js-debug-adapter",
        "marksman",
        "prettier",
        "shellcheck",
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "yaml-language-server",
      },
    -- end Customs LSP
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "cmake",
        "comment",
        "css",
        "csv",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gpg",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "jsonnet",
        "python",
        "regex",
        "requirements",
        "terraform",
        "tsx",
        "typescript",
        "xml",
        "yaml",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}

return plugins
