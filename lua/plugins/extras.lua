-- ==============================================
-- Additional productivity plugins
-- Autopairs, Surround, Comment, Todo-comments, Markdown Preview
-- ==============================================

return {
  -- ==========================
  -- Markdown Preview
  -- Preview markdown files in browser
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
