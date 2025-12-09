-- ==============================================
-- Autocommands
-- ==============================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ==============================================
-- NvimTree Auto-open on startup (if no file specified)
-- ==============================================
autocmd("VimEnter", {
  group = augroup("NvimTreeAutoOpen", { clear = true }),
  callback = function()
    local argc = vim.fn.argc()
    if argc == 0 then
      vim.schedule(function()
        vim.cmd("NvimTreeOpen")
      end)
    end
  end,
})

-- ==============================================
-- Fugitive (:Git) opens at bottom
-- Create split at bottom, then open status with :Gedit :
-- ==============================================
vim.api.nvim_create_user_command("G", function()
  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.cmd("Gedit :")
end, { nargs = 0 })

vim.api.nvim_create_user_command("Git", function(opts)
  if opts.args == "" then
    -- No args = status, open at bottom
    vim.cmd("botright split")
    vim.cmd("resize 15")
    vim.cmd("Gedit :")
  else
    -- With args, run normal Git command
    vim.cmd("tab Git " .. opts.args)
  end
end, { nargs = "*" })

-- ==============================================
-- ESLint auto-fix on save for JS/TS files
-- ==============================================
autocmd("BufWritePre", {
  group = augroup("EslintFixAll", { clear = true }),
  pattern = { "*.jsx", "*.js", "*.tsx", "*.ts" },
  callback = function()
    -- Only run if eslint LSP is attached
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "eslint" })
    if #clients > 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- ==============================================
-- Terraform format on save
-- ==============================================
autocmd("BufWritePre", {
  group = augroup("TerraformFormat", { clear = true }),
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- ==============================================
-- Terraform/HCL filetype detection
-- ==============================================
vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform",
    hcl = "hcl",
    tfstate = "json",
  },
  filename = {
    [".terraformrc"] = "hcl",
    ["terraform.rc"] = "hcl",
  },
  pattern = {
    ["*.tfstate.backup"] = "json",
  },
})
