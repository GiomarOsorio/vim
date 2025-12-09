-- UI configuration: Theme, colorscheme, dashboard and UI plugins

return {

	------------------------------------------------------------------------------
	-- THEME (Gruvbox) - Immediate load, needed for UI
	------------------------------------------------------------------------------
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "medium",
				transparent_mode = false,
				overrides = {},
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},

	------------------------------------------------------------------------------
	-- LUALINE - Custom Gruvbox theme
	------------------------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Gruvbox colors
			local colors = {
				bg = "#282828",
				bg1 = "#3c3836",
				bg2 = "#504945",
				fg = "#ebdbb2",
				fg4 = "#a89984",
				yellow = "#d79921",
				orange = "#d65d0e",
				red = "#cc241d",
				green = "#98971a",
				aqua = "#689d6a",
				blue = "#458588",
				purple = "#b16286",
			}

			-- Custom Gruvbox theme for lualine
			local gruvbox_theme = {
				normal = {
					a = { bg = colors.aqua, fg = colors.bg, gui = "bold" },
					b = { bg = colors.bg2, fg = colors.fg },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
				insert = {
					a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
					b = { bg = colors.bg2, fg = colors.fg },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
				visual = {
					a = { bg = colors.orange, fg = colors.bg, gui = "bold" },
					b = { bg = colors.bg2, fg = colors.fg },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
				replace = {
					a = { bg = colors.red, fg = colors.bg, gui = "bold" },
					b = { bg = colors.bg2, fg = colors.fg },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
				command = {
					a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
					b = { bg = colors.bg2, fg = colors.fg },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
				inactive = {
					a = { bg = colors.bg1, fg = colors.fg4 },
					b = { bg = colors.bg1, fg = colors.fg4 },
					c = { bg = colors.bg1, fg = colors.fg4 },
				},
			}

			require("lualine").setup({
				options = {
					theme = gruvbox_theme,
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = {
						{ "branch", icon = "" },
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " },
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.yellow },
								removed = { fg = colors.red },
							},
						},
					},
					lualine_c = {
						{ "filename", path = 1, symbols = { modified = " ●", readonly = " " } },
					},
					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
							diagnostics_color = {
								error = { fg = colors.red },
								warn = { fg = colors.yellow },
								info = { fg = colors.blue },
								hint = { fg = colors.aqua },
							},
						},
					},
					lualine_y = {
						{ "filetype", icon_only = false },
						{ "encoding" },
						{ "fileformat", symbols = { unix = "", dos = "", mac = "" } },
					},
					lualine_z = {
						{ "progress" },
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "nvim-tree", "lazy", "fugitive", "trouble" },
			})
		end,
	},

	------------------------------------------------------------------------------
	-- BUFFERLINE - Complete configuration with Gruvbox
	-- Hover, underline, LSP diagnostics, sidebar offsets, pinning, reordering
	------------------------------------------------------------------------------
	{
		"akinsho/bufferline.nvim",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Gruvbox colors for bufferline
			local colors = {
				bg = "#282828",
				bg1 = "#3c3836",
				bg2 = "#504945",
				bg3 = "#665c54",
				fg = "#ebdbb2",
				fg4 = "#a89984",
				yellow = "#d79921",
				orange = "#d65d0e",
				red = "#cc241d",
				green = "#98971a",
				aqua = "#689d6a",
				blue = "#458588",
				purple = "#b16286",
			}

			require("bufferline").setup({
				options = {
					-- Mode and style
					mode = "buffers",
					style_preset = require("bufferline").style_preset.default,
					themable = true,

					-- Numbers
					numbers = "none",

					-- Close buffers
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = "bdelete! %d",

					-- Underline indicator
					indicator = {
						icon = "▎",
						style = "underline",
					},

					-- Icons
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",

					-- LSP Diagnostics
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_update_on_event = true,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icons = {
							error = " ",
							warning = " ",
							info = " ",
							hint = "󰌵 ",
						}
						local icon = icons[level] or ""
						return " " .. icon .. count
					end,

					-- Sidebar offsets (NvimTree, etc.)
					offsets = {
						{
							filetype = "NvimTree",
							text = "  File Explorer",
							text_align = "left",
							separator = true,
							highlight = "Directory",
						},
						{
							filetype = "DiffviewFiles",
							text = "  Diff View",
							text_align = "left",
							separator = true,
						},
						{
							filetype = "lazy",
							text = "  Lazy",
							text_align = "left",
							separator = true,
						},
					},

					-- Colors by file
					color_icons = true,
					get_element_icon = function(element)
						local icon, hl =
							require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
						return icon, hl
					end,

					-- Show close icons
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true,

					-- Persist buffer order
					persist_buffer_sort = true,

					-- Separator
					separator_style = "thin",

					-- Hover events
					hover = {
						enabled = true,
						delay = 150,
						reveal = { "close" },
					},

					-- Sorting
					sort_by = "insert_after_current",

					-- Groups (for pinning)
					groups = {
						options = {
							toggle_hidden_on_enter = true,
						},
						items = {
							require("bufferline.groups").builtin.pinned:with({ icon = "󰐃 " }),
							require("bufferline.groups").builtin.ungrouped,
						},
					},
				},

				-- Gruvbox highlights
				highlights = {
					-- General background
					fill = {
						fg = colors.fg4,
						bg = colors.bg,
					},

					-- Background buffer (not selected)
					background = {
						fg = colors.fg4,
						bg = colors.bg1,
					},

					-- Selected buffer
					buffer_selected = {
						fg = colors.fg,
						bg = colors.bg,
						bold = true,
						italic = false,
					},
					buffer_visible = {
						fg = colors.fg4,
						bg = colors.bg1,
					},

					-- Close icons
					close_button = {
						fg = colors.fg4,
						bg = colors.bg1,
					},
					close_button_visible = {
						fg = colors.fg4,
						bg = colors.bg1,
					},
					close_button_selected = {
						fg = colors.red,
						bg = colors.bg,
					},

					-- Separators
					separator = {
						fg = colors.bg,
						bg = colors.bg1,
					},
					separator_selected = {
						fg = colors.bg,
						bg = colors.bg,
					},
					separator_visible = {
						fg = colors.bg,
						bg = colors.bg1,
					},

					-- Indicator (underline)
					indicator_selected = {
						fg = colors.aqua,
						bg = colors.bg,
					},
					indicator_visible = {
						fg = colors.bg2,
						bg = colors.bg1,
					},

					-- Modified
					modified = {
						fg = colors.yellow,
						bg = colors.bg1,
					},
					modified_selected = {
						fg = colors.yellow,
						bg = colors.bg,
					},
					modified_visible = {
						fg = colors.yellow,
						bg = colors.bg1,
					},

					-- Duplicates
					duplicate = {
						fg = colors.fg4,
						bg = colors.bg1,
						italic = true,
					},
					duplicate_selected = {
						fg = colors.fg,
						bg = colors.bg,
						italic = true,
					},
					duplicate_visible = {
						fg = colors.fg4,
						bg = colors.bg1,
						italic = true,
					},

					-- Diagnostics - Error
					error = {
						fg = colors.red,
						bg = colors.bg1,
					},
					error_selected = {
						fg = colors.red,
						bg = colors.bg,
						bold = true,
					},
					error_visible = {
						fg = colors.red,
						bg = colors.bg1,
					},
					error_diagnostic = {
						fg = colors.red,
						bg = colors.bg1,
					},
					error_diagnostic_selected = {
						fg = colors.red,
						bg = colors.bg,
						bold = true,
					},
					error_diagnostic_visible = {
						fg = colors.red,
						bg = colors.bg1,
					},

					-- Diagnostics - Warning
					warning = {
						fg = colors.yellow,
						bg = colors.bg1,
					},
					warning_selected = {
						fg = colors.yellow,
						bg = colors.bg,
						bold = true,
					},
					warning_visible = {
						fg = colors.yellow,
						bg = colors.bg1,
					},
					warning_diagnostic = {
						fg = colors.yellow,
						bg = colors.bg1,
					},
					warning_diagnostic_selected = {
						fg = colors.yellow,
						bg = colors.bg,
						bold = true,
					},
					warning_diagnostic_visible = {
						fg = colors.yellow,
						bg = colors.bg1,
					},

					-- Diagnostics - Info
					info = {
						fg = colors.blue,
						bg = colors.bg1,
					},
					info_selected = {
						fg = colors.blue,
						bg = colors.bg,
						bold = true,
					},
					info_visible = {
						fg = colors.blue,
						bg = colors.bg1,
					},
					info_diagnostic = {
						fg = colors.blue,
						bg = colors.bg1,
					},
					info_diagnostic_selected = {
						fg = colors.blue,
						bg = colors.bg,
						bold = true,
					},
					info_diagnostic_visible = {
						fg = colors.blue,
						bg = colors.bg1,
					},

					-- Diagnostics - Hint
					hint = {
						fg = colors.aqua,
						bg = colors.bg1,
					},
					hint_selected = {
						fg = colors.aqua,
						bg = colors.bg,
						bold = true,
					},
					hint_visible = {
						fg = colors.aqua,
						bg = colors.bg1,
					},
					hint_diagnostic = {
						fg = colors.aqua,
						bg = colors.bg1,
					},
					hint_diagnostic_selected = {
						fg = colors.aqua,
						bg = colors.bg,
						bold = true,
					},
					hint_diagnostic_visible = {
						fg = colors.aqua,
						bg = colors.bg1,
					},

					-- Tab
					tab = {
						fg = colors.fg4,
						bg = colors.bg1,
					},
					tab_selected = {
						fg = colors.fg,
						bg = colors.bg,
						bold = true,
					},
					tab_separator = {
						fg = colors.bg,
						bg = colors.bg1,
					},
					tab_separator_selected = {
						fg = colors.bg,
						bg = colors.bg,
					},
					tab_close = {
						fg = colors.red,
						bg = colors.bg1,
					},

					-- Numbers
					numbers = {
						fg = colors.fg4,
						bg = colors.bg1,
					},
					numbers_selected = {
						fg = colors.fg,
						bg = colors.bg,
						bold = true,
					},
					numbers_visible = {
						fg = colors.fg4,
						bg = colors.bg1,
					},

					-- Pick
					pick = {
						fg = colors.red,
						bg = colors.bg1,
						bold = true,
					},
					pick_selected = {
						fg = colors.red,
						bg = colors.bg,
						bold = true,
					},
					pick_visible = {
						fg = colors.red,
						bg = colors.bg1,
						bold = true,
					},

					-- Offset separator
					offset_separator = {
						fg = colors.bg2,
						bg = colors.bg,
					},

					-- Trunc marker
					trunc_marker = {
						fg = colors.fg4,
						bg = colors.bg,
					},
				},
			})

			-- Keymaps for bufferline
			local map = vim.keymap.set

			-- Navigation
			map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
			map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })

			-- Reordering (move buffers)
			map("n", "<leader>bn", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
			map("n", "<leader>bp", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })

			-- Pinning
			map("n", "<leader>bP", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin/Unpin buffer" })

			-- Go to buffer by position
			map("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Go to buffer 1" })
			map("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Go to buffer 2" })
			map("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Go to buffer 3" })
			map("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Go to buffer 4" })
			map("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Go to buffer 5" })
			map("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Go to buffer 6" })
			map("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Go to buffer 7" })
			map("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Go to buffer 8" })
			map("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Go to buffer 9" })

			-- Close buffers
			map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
			map("n", "<leader>bC", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
			map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers to the left" })
			map("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers to the right" })

			-- Pick buffer
			map("n", "<leader>bb", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })

			-- Sort
			map("n", "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", { desc = "Sort by directory" })
			map("n", "<leader>bS", "<cmd>BufferLineSortByExtension<cr>", { desc = "Sort by extension" })
		end,
	},

	------------------------------------------------------------------------------
	-- DASHBOARD (TurtleSRE)
	------------------------------------------------------------------------------
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			local db = require("dashboard")

			db.setup({
				theme = "hyper",
				config = {
					header = {
						"",
						"████████╗██╗   ██╗██████╗ ████████╗██╗     ███████╗",
						"╚══██╔══╝██║   ██║██╔══██╗╚══██╔══╝██║     ██╔════╝",
						"   ██║   ██║   ██║██████╔╝   ██║   ██║     █████╗  ",
						"   ██║   ██║   ██║██╔══██╗   ██║   ██║     ██╔══╝  ",
						"   ██║   ╚██████╔╝██║  ██║   ██║   ███████╗███████╗",
						"   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚══════╝",
						"",
						"TurtleSRE",
						"",
					},

					shortcut = {
						{ desc = "󰈔 New file", group = "@string", action = "enew", key = "n" },
						{ desc = " Open NvimTree", group = "@property", action = "NvimTreeToggle", key = "e" },
						{
							desc = "󰱼 Find files",
							group = "@constant",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Recent files",
							group = "@function",
							action = "Telescope oldfiles",
							key = "r",
						},
					},

					footer = {
						"",
						"Keep the shell clean, the system stable, and the mind clear.",
					},
				},
			})
		end,
	},

	------------------------------------------------------------------------------
	-- NOTIFY - Load when needed
	------------------------------------------------------------------------------
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				background_colour = "#282828",
				render = "wrapped-compact",
				stages = "fade",
				timeout = 2000,
			})
			vim.notify = require("notify")
		end,
	},

	------------------------------------------------------------------------------
	-- INDENT BLANKLINE - Load when reading files
	------------------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = false },
			})
		end,
	},
}
