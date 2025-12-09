-- ============================================
-- Plugin: Telescope (Fuzzy Finder)
-- ============================================
-- Powerful fuzzy finder for files, text, buffers, and more.
-- Essential tool for fast navigation in large codebases.
--
-- Features:
--   - Fuzzy file finding with preview
--   - Live grep (search text across project)
--   - Buffer and recent file navigation
--   - LSP diagnostic search
--   - Help tag search
--   - Fast C-based fuzzy matching (fzf-native)
--   - Hidden file support
--
-- Keymaps:
--   <leader>ff - Find files
--   <leader>fg - Live grep (search text in project)
--   <leader>fb - List open buffers
--   <leader>fh - Search help tags
--   <leader>fo - Recent files (oldfiles)
--   <leader>fd - List diagnostics
--
-- Inside Telescope:
--   <C-j>/<C-k> - Navigate up/down
--   <C-q>       - Send results to quickfix list
--   <Esc>       - Close telescope
--
-- Plugin: telescope.nvim + telescope-fzf-native.nvim
-- Repo: nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  -- Lazy load: only load when needed
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- Compiles C code for faster fuzzy matching
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
    -- Keymaps moved to keys section for lazy loading
  end,
}
