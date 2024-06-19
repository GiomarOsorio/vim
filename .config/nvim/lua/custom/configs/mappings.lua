local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<C-a>"] = "",
      ["<C-n>"] = "",
      ["<leader>b"] = "",
      ["<leader>e"] =  "",
      ["<leader>gl"] = "",
      ["<leader>q"] = "",
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
    ["ff"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>h"] = { "<C-w>h", "Window left" },
    ["<leader>k"] = { "<C-w>k", "Window up" },
    ["<leader>j"] = { "<C-w>j", "Window down" },
    ["<leader>l"] = { "<C-w>l", "Window right" },
    ["h"] = { "<Left>", "Move left" },
    ["n"] = { "<Up>", "Move up" },
    ["t"] = { "<Down>", "Move down" },
    ["s"] = { "<Right>", "Move right" },
  },
  i = {
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-k>"] = { "<Up>", "Move up" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-l>"] = { "<Right>", "Move right" },
  },
  v = {
    ["h"] = { "<Left>", "Move left" },
    ["k"] = { "<Up>", "Move up" },
    ["j"] = { "<Down>", "Move down" },
    ["l"] = { "<Right>", "Move right" },
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

M.nvterm = {
  plugin = true,

  n = {
    ["<C-u>"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<C-e>"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
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
