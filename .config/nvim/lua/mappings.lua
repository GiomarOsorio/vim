require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- Disable mappings
-- nomap("n", "<C-a>")
-- nomap("n", "<C-n>")
-- nomap("n", "<leader>e")
-- nomap("n", "<leader>b")
-- nomap("n", "<leader>q")
-- nomap("n", "<leader>gl")

-- Enable mappings
map("n", "ff", "<cmd> enew <CR>", { desc = "New buffer"})
-- Corne Split Keyboard
map({"n","v"}, "h", "<Left>", { desc = "move left" })
map({"n","v"}, "s", "<Right>", { desc = "move right" })
map({"n","v"}, "t", "<Down>", { desc = "move down" })
map({"n","v"}, "n", "<Up>", { desc = "move up" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-s>", "<Right>", { desc = "move right" })
map("i", "<C-t>", "<Down>", { desc = "move down" })
map("i", "<C-n>", "<Up>", { desc = "move up" })
map("n", "<leader>h", "<C-w>h", { desc = "Window left" })
map("n", "<leader>s", "<C-w>s", { desc = "Window right" })
map("n", "<leader>t", "<C-w>t", { desc = "Window down" })
map("n", "<leader>n", "<C-w>n", { desc = "Window up" })
-- Complete Keyboard
map({"n","v"}, "l", "<Right>", { desc = "move right" })
map({"n","v"}, "j", "<Down>", { desc = "move down" })
map({"n","v"}, "k", "<Up>", { desc = "move up" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("n", "<leader>l", "<C-w>l", { desc = "Window right" })
map("n", "<leader>j", "<C-w>j", { desc = "Window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Window up" })
-- Terminals
map("n", "<C-u>", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })
map("n", "<C-e>", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })
-- NvimTree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
