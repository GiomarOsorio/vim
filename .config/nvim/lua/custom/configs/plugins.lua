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
    dependencies = "mfussenegger/nvim-dap",
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
        "typescript-language-server",
        "yaml-language-server",
      },
    -- end Customs LSP
    },
  },
}
return plugins
