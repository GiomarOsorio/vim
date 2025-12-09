-- ============================================
-- Plugin: Extra Productivity Tools
-- ============================================
-- Collection of essential productivity plugins for a better editing experience.
-- Includes markdown preview, autopairs, surround, commenting, TODOs, and navigation.
--
-- This file contains 6 productivity plugins:
--   1. Markdown Preview  - Live markdown preview in browser
--   2. Autopairs         - Auto-close brackets, quotes, etc.
--   3. Surround          - Manipulate surrounding characters
--   4. Comment           - Smart commenting
--   5. Todo-comments     - Highlight and search TODO/FIXME/HACK
--   6. Flash             - Fast navigation with improved search
--
-- Markdown Preview:
--   <leader>mp - Toggle preview in browser
--
-- Autopairs:
--   - Auto-closes: (), [], {}, "", '', ``
--   - Treesitter-aware (skips in strings/comments)
--
-- Surround:
--   cs"'   - Change surrounding " to '
--   ds"    - Delete surrounding "
--   ysiw)  - Surround word with ()
--   yss)   - Surround entire line
--
-- Comment:
--   gcc    - Toggle comment on current line
--   gc     - Toggle comment on selection (visual mode)
--   gcap   - Comment around paragraph
--   gb     - Block comment
--
-- Todo-comments:
--   Highlights: TODO, FIXME, HACK, WARN, PERF, NOTE, TEST
--   ]t / [t         - Next/Previous TODO
--   <leader>xt      - Show TODOs in Trouble
--   <leader>ft      - Search TODOs with Telescope
--
-- Flash (Fast Navigation):
--   s   - Flash jump (search and jump with labels)
--   S   - Flash treesitter (jump by syntax nodes)
--   r   - Remote flash (operator mode)
--   R   - Treesitter search
--
-- Plugins: markdown-preview.nvim, nvim-autopairs, nvim-surround,
--          Comment.nvim, todo-comments.nvim, flash.nvim

return {
  -- ==========================
  -- Markdown Preview - Live browser preview
  -- ==========================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    },
  },

  -- ==========================
  -- Autopairs
  -- Automatically closes parentheses, brackets, etc.
  -- ==========================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,                      -- Use treesitter for validation
      ts_config = {
        lua = { "string" },                 -- No autopairs in Lua strings
        javascript = { "template_string" }, -- No in template strings
      },
    },
  },

  -- ==========================
  -- Surround
  -- Operations with "surroundings" (parentheses, quotes, tags)
  -- cs"'  -> change " to '
  -- ds"   -> delete "
  -- ysiw) -> surround word with ()
  -- ==========================
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ==========================
  -- Comment
  -- Easily comment/uncomment code
  -- gcc -> comment line
  -- gc  -> comment selection (visual)
  -- gcap -> comment paragraph
  -- ==========================
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment" },
      { "gb", mode = { "n", "v" }, desc = "Comment (block)" },
    },
    opts = {},
  },

  -- ==========================
  -- Todo-comments
  -- Highlights and searches for TODO, FIXME, HACK, etc.
  -- ==========================
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search TODOs (Telescope)" },
    },
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },

  -- ==========================
  -- Flash.nvim
  -- Fast navigation with improved search
  -- s -> start search and jump
  -- S -> treesitter search
  -- ==========================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
}
