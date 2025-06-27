require "nvchad.autocmds"

local lspconfig = require "lspconfig"

local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn
local util = lspconfig.util
local std_in = false

function STDChange ()
  std_in = true
end

function NERDTreeAutoClose ()
  local buffnr = #vim.api.nvim_list_wins()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if ( buffnr == 1 and ft == "NvimTree" ) then
    vim.cmd "quit"
  end
end

function NERDTreeAutoOpen ()
  local argc = vim.v.argc
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if ( argc == nil and ft == "" ) then
    vim.cmd ":NvimTreeOpen"
  end
end

function NERDTreeRefresh ()
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if ft == "NvimTree" then
    vim.cmd "NvimTreeRefresh"
  end
end

autocmd("StdinReadPre", {
  pattern = "*",
  callback = function()
    vim.schedule(STDChange)
  end,
})

autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.schedule(NERDTreeAutoClose)
  end,
})

autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.schedule(NERDTreeAutoOpen)
  end,
})

autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.schedule(NERDTreeRefresh)
  end,
})

-- JavaScript/Typescript LSP
vim.cmd [[autocmd BufWritePre *.jsx,*.js,*tsx,*ts EslintFixAll]]

-- Terraform LSP
autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

