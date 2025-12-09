-- GitHub Copilot integration
local config = require("config")
if not config.enable_copilot then
  return {}
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- CopilotChat for interactive AI chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Fix code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Optimize code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "Generate docs" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "Generate tests" },
    },
    opts = {
      model = "gpt-4.1",
      temperature = 0.1,
      window = {
        layout = "vertical",
        width = 0.5,
      },
      auto_insert_mode = true,
    },
  },
}
