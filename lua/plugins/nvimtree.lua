-- ============================================
-- Plugin: NvimTree (File Explorer)
-- ============================================
-- Modern file explorer tree for Neovim with icons and git integration.
-- Provides a visual way to browse and manage project files.
--
-- Features:
--   - Tree-style file navigation
--   - Git status indicators
--   - File/directory operations (create, delete, rename, copy)
--   - Window picker for opening files in specific splits
--   - Auto-close when it's the last window
--   - Shows hidden files (important for SRE work)
--   - File icons via nvim-web-devicons
--
-- Keymaps:
--   <leader>e - Toggle NvimTree
--
-- Inside NvimTree:
--   <CR>     - Open file/folder
--   a        - Create file/folder (end with / for folder)
--   d        - Delete file/folder
--   r        - Rename file/folder
--   c        - Copy file/folder
--   p        - Paste
--   y        - Copy name
--   Y        - Copy absolute path
--   R        - Refresh tree
--   H        - Toggle hidden files
--   I        - Toggle ignored files
--   E        - Expand all folders
--   W        - Collapse all folders
--
-- Plugin: nvim-tree.lua
-- Repo: nvim-tree/nvim-tree.lua

return {
  "nvim-tree/nvim-tree.lua",
  -- Lazy load: only when needed
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,  -- Show hidden files (important for SRE)
      },
      -- Close NvimTree if it's the last window
      actions = {
        open_file = {
          quit_on_open = false,  -- Don't close when opening file
          resize_window = true,  -- Resize window when opening file
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
    })

    -- Auto-close NvimTree when it's the last window (but respect Dashboard)
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local dashboard_open = false
        local wins = vim.api.nvim_list_wins()

        for _, w in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(w)
          local bufname = vim.api.nvim_buf_get_name(buf)
          local filetype = vim.bo[buf].filetype

          -- Check if Dashboard is open
          if filetype == "dashboard" then
            dashboard_open = true
          end

          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
            table.insert(floating_wins, w)
          end
        end

        -- If Dashboard is open, don't do anything
        if dashboard_open then
          return
        end

        -- If only NvimTree and floating windows remain, close NvimTree
        if #wins - #floating_wins - #tree_wins == 1 then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
