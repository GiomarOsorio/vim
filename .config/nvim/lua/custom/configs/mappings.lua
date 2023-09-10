local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<C-a>"] = "",
      ["<C-n>"] = "",
      ["<leader>b"] = "",
      ["<leader>e"] =  "",
      ["<leader>gl"] = "",
      ["<leader>q"] = ""
   }
}

-- Your custom mappings
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
    ["<leader>dr"] = { "<cmd> DapContinue <CR>", "Run or continue the debugger" },
  },
}

M.general = {
  n = {
    ["tt"] = { "<cmd> enew <CR>", "New buffer" },
  },
}

M.lsp = {
  plugin = true,
  n = {
    --- windows
    ["<leader>gl"] = { "<cmd> lua vim.diagnostic.open_float() <CR>", "Show diagnostics in a floating window"},
    ["[d"] = { "<cmd> lua vim.diagnostic.goto_prev() <CR>", "Move to the previous diagnostic in the current buffer"},
    ["]d"] = { "<cmd> lua vim.diagnostic.goto_next() <CR>", "Move to the next diagnostic"},
    ["<leader>q"] = { "<cmd> lua vim.diagnostic.setloclist() <CR>", "Add buffer diagnostics to the location list"},
  }
}

M.nvimtree = {
  plugin = true,
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

return M
