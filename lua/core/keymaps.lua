-- ============================================
-- General Neovim Keymaps
-- ============================================
-- This file defines global keymaps that work across the entire editor.
-- Supports both QWERTY (h,j,k,l) and Dvorak Programming (h,t,n,s) layouts.
--
-- Layout Philosophy:
--   - QWERTY users: Standard Vim navigation (hjkl)
--   - Dvorak users: Ergonomic navigation (htns) on home row
--   - Both layouts work simultaneously
--
-- Sections:
--   1. Buffers - Create, close, navigate buffers
--   2. Navigation - Basic movement and search
--   3. Windows - Split management
--   4. Movement QWERTY - Standard hjkl navigation
--   5. Movement Dvorak - Alternative htns navigation
--   6. Dvorak Remaps - Restore t/n/s original functions
--   7. Insert Mode - Ctrl+movement in insert mode
--   8. Terminal - Terminal split commands
--   9. Copilot - AI completion accept
--  10. Format - Code formatting
--  11. Git - Fugitive commands
--
-- Note: Plugin-specific keymaps are defined in their respective files.

local map = vim.keymap.set

-- Leader key: Space (both leader and localleader)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================
-- Buffers (Tab/S-Tab are in bufferline.lua)
-- ============================================
-- New buffer
map("n", "ff", "<cmd>enew<CR>", { desc = "New buffer" })

-- Smart buffer close:
-- 1. If more buffers exist, go to previous
-- 2. If last buffer, also close NvimTree
map("n", "<leader>x", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local buftype = vim.bo[bufnr].buftype

	-- Don't close if it's NvimTree or other special buffer
	if buftype ~= "" then
		vim.cmd("close")
		return
	end

	-- Count real buffers (non-special)
	local real_bufs = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
			real_bufs = real_bufs + 1
		end
	end

	-- If last real buffer, also close NvimTree
	if real_bufs <= 1 then
		-- Close NvimTree if open
		local nvim_tree_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
		if nvim_tree_ok then
			nvim_tree_api.tree.close()
		end
		vim.cmd("bd")
	else
		-- Go to previous buffer and close current
		vim.cmd("bp | bd #")
	end
end, { desc = "Close current buffer" })

-- ============================================
-- Basic Navigation
-- ============================================
-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear highlight" })

-- Save and close
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Close" })

-- ============================================
-- Windows
-- ============================================
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
map("n", "<leader>sx", ":close<CR>", { desc = "Close window" })

-- ============================================
-- MOVEMENT - QWERTY (h,j,k,l)
-- ============================================
-- Normal / Visual - Basic movement
map({ "n", "v" }, "h", "<Left>", { desc = "[Dvorak] Move down" })
map({ "n", "v" }, "j", "<Down>", { desc = "[Dvorak] Move down" })
map({ "n", "v" }, "k", "<Up>", { desc = "[Dvorak] Move up" })
map({ "n", "v" }, "l", "<Right>", { desc = "[Dvorak] Move right" })

-- Window navigation (QWERTY)
map("n", "<leader>h", "<C-w>h", { desc = "Window left" })
map("n", "<leader>j", "<C-w>j", { desc = "Window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Window up" })
map("n", "<leader>l", "<C-w>l", { desc = "Window right" })

-- ============================================
-- MOVEMENT - DVORAK PROGRAMMING (h,t,n,s)
-- h = left (same as QWERTY)
-- t = down     (replaces j)
-- n = up       (replaces k)
-- s = right    (replaces l)
-- ============================================
-- Normal / Visual - Basic Dvorak movement
map({ "n", "v" }, "t", "<Down>", { desc = "[Dvorak] Move down" })
map({ "n", "v" }, "n", "<Up>", { desc = "[Dvorak] Move up" })
map({ "n", "v" }, "s", "<Right>", { desc = "[Dvorak] Move right" })

-- Window navigation (Dvorak)
map("n", "<leader>t", "<C-w>j", { desc = "[Dvorak] Window down" })
map("n", "<leader>n", "<C-w>k", { desc = "[Dvorak] Window up" })
map("n", "<leader>s", "<C-w>l", { desc = "[Dvorak] Window right" })

-- ============================================
-- Remapping commands affected by Dvorak
-- t, n, s have original functions in Vim
-- ============================================
-- 't' original: till character -> use 'j' in Dvorak
map({ "n", "v", "o" }, "fj", "t", { desc = "Till (to character)" })
-- 'T' original: till backwards -> use 'J'
map({ "n", "v", "o" }, "FJ", "T", { desc = "Till backwards" })

-- 'n' original: next search -> use 'l' in Dvorak
map({ "n", "v", "o" }, "fl", "n", { desc = "Next search" })
-- 'N' original: previous search -> use 'L'
map({ "n", "v", "o" }, "fL", "N", { desc = "Previous search" })

-- 's' original: substitute character -> use 'k' in Dvorak
map("n", "fk", "s", { desc = "Substitute character" })
-- 'S' original: substitute line -> use 'K'
map("n", "FK", "S", { desc = "Substitute line" })

-- ============================================
-- Insert Mode - Movement with Ctrl
-- Works the same for both layouts
-- ============================================
-- QWERTY style
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
-- Dvorak style
map("i", "<C-t>", "<Down>", { desc = "[Dvorak] Move down" })
map("i", "<C-n>", "<Up>", { desc = "[Dvorak] Move up" })
map("i", "<C-s>", "<Right>", { desc = "[Dvorak] Move right" })

-- ============================================
-- Floating or split terminals (NvChad)
-- ============================================
map("n", "<C-u>", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "Horizontal terminal" })

map("n", "<C-e>", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "Vertical terminal" })

-- Terminal ToggleTerm
map("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Terminal ToggleTerm" })

-- ============================================
-- Copilot (only if you use it)
-- ============================================
map("i", "<C-f>", 'copilot#Accept("\\<S-Tab>")', {
	expr = true,
	replace_keycodes = false,
	desc = "Accept Copilot suggestion",
})

-- ============================================
-- Format file
-- ============================================
map("n", "<leader>f", function()
	require("conform").format()
end, { desc = "Format file" })

-- ============================================
-- Git (Fugitive)
-- ============================================
map("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
map("n", "<leader>gl", ":Git pull<CR>", { desc = "Git pull" })
map("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff split" })
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
map("n", "<leader>gL", ":Git log<CR>", { desc = "Git log" })
