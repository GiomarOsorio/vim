-- ============================================
-- Plugin: Git Integration
-- ============================================
-- Comprehensive Git integration with multiple complementary plugins.
-- Provides in-editor Git status, diffs, history, and a full TUI interface.
--
-- This file contains 4 Git plugins:
--   1. Gitsigns   - Git decorations and hunk operations in the gutter
--   2. Fugitive   - Git commands (:Git) integrated in Neovim
--   3. Diffview   - Advanced diff and merge tool with file history
--   4. LazyGit    - Full-featured Git TUI (terminal UI)
--
-- Gitsigns Features:
--   - Git diff indicators in sign column
--   - Inline blame (shows author and time on current line)
--   - Stage/unstage hunks
--   - Preview changes
--   - Navigate between changes
--
-- Gitsigns Keymaps:
--   ]c          - Next change (hunk)
--   [c          - Previous change (hunk)
--   <leader>hs  - Stage hunk
--   <leader>hr  - Reset hunk
--   <leader>hS  - Stage buffer
--   <leader>hR  - Reset buffer
--   <leader>hp  - Preview hunk
--   <leader>hb  - Toggle inline blame
--
-- Fugitive Keymaps (from core/keymaps.lua):
--   <leader>gs  - Git status (:Git)
--   <leader>gc  - Git commit
--   <leader>gp  - Git push
--   <leader>gl  - Git pull
--   <leader>gd  - Git diff split
--   <leader>gb  - Git blame
--   <leader>gL  - Git log
--
-- Diffview Keymaps:
--   <leader>gv  - Open Diffview (compare changes)
--   <leader>gV  - Close Diffview
--   <leader>gh  - File history (current file)
--   <leader>gH  - Repository history (all files)
--
-- LazyGit Keymaps:
--   <leader>gg  - Open LazyGit TUI
--
-- Plugins: gitsigns.nvim, vim-fugitive, diffview.nvim, lazygit.nvim

return {
	-- ==========================
	-- Gitsigns - Git decorations and hunk operations
	-- ==========================
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "│" },
				},

				current_line_blame = true, -- Show author/time on current line
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 300,
				},

				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
					end

					-- Navigate between changes
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						gs.next_hunk()
					end)

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						gs.prev_hunk()
					end)

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)

					-- Toggle blame
					map("n", "<leader>hb", gs.toggle_current_line_blame)
				end,
			})
		end,
	},

	-- ==========================
	-- Fugitive (Optional)
	-- Git commands inside Neovim
	-- ==========================
	{
		"tpope/vim-fugitive",
		lazy = false,
	},

	-- ==========================
	-- Diffview
	-- Advanced diff and history view
	-- ==========================
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
			{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},

	-- ==========================
	-- LazyGit
	-- Full TUI interface for Git
	-- ==========================
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
}
