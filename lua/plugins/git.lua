-- ==============================================
-- Git related plugins
-- ==============================================

return {
	-- ==========================
	-- Git indicators and actions
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
