-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

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
