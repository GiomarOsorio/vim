local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<leader>b"] = "",
      ["<C-a>"] = "",
      ["<C-n>"] = "",
      ["<leader>e"] =  ""
   }
}

-- Your custom mappings
M.general = {
  n = {
    ["tt"] = { "<cmd> enew <CR>", "New buffer" },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.dap = {
  plugin = true,

  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
    ["<leader>dr"] = { "<cmd> DapContinue <CR>", "Run or continue the debugger" },

  },
}

return M
