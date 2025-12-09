-- ================================
-- General Neovim Options
-- ================================

local o = vim.opt

-- ================================
-- Interface
-- ================================
o.number = true -- Line numbers
o.relativenumber = true -- Relative numbers
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.cursorline = false -- Disable current line highlight
o.termguicolors = true -- Modern colors
o.signcolumn = "yes" -- Always show sign column
o.wrap = false -- Don't wrap lines
o.scrolloff = 8 -- Keep context when moving cursor
o.sidescrolloff = 8 -- Keep context when scrolling horizontally
o.cmdheight = 4 -- More space for command line messages
o.splitbelow = true -- split horizontally and below
o.splitright = true -- split vertically and right

-- ================================
-- Files
-- ================================
o.backup = false -- Don't create backup files
o.writebackup = false -- Don't create backup while editing
o.undofile = true -- Enable persistent undo

-- ================================
-- Mouse
-- ================================
o.mouse = "" -- Disable mouse

-- ================================
-- Search
-- ================================
o.ignorecase = true

-- Suppress some messages
o.shortmess:append("c")
