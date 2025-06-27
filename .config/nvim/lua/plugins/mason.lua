return {
  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
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
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  }
}
