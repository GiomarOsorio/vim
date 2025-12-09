-- ================================
-- General Neovim Options
-- ================================
-- This file configures Neovim's core behavior and appearance.
-- All settings use vim.opt (the modern Lua API) for better type safety.

local o = vim.opt

-- ================================
-- INTERFACE & APPEARANCE
-- ================================

-- Line Numbers
o.number = true          -- Show absolute line numbers on current line
o.relativenumber = true  -- Show relative numbers for other lines (great for motions like 5j)

-- Indentation
o.tabstop = 2       -- Number of spaces a tab character displays as
o.shiftwidth = 2    -- Number of spaces for each indent level (>>, <<, ==)
o.expandtab = true  -- Convert tabs to spaces (recommended for most languages)

-- Visual Guides
o.cursorline = false      -- Don't highlight current line (less visual clutter)
o.signcolumn = "yes"      -- Always show sign column (prevents text shifting for git/diagnostic signs)
o.termguicolors = true    -- Enable 24-bit RGB colors (required for modern themes)

-- Line Wrapping
o.wrap = false  -- Don't wrap long lines (better for code reading)

-- Scrolling Context
o.scrolloff = 8       -- Keep 8 lines visible above/below cursor when scrolling
o.sidescrolloff = 8   -- Keep 8 columns visible left/right of cursor

-- Command Line
o.cmdheight = 4  -- Height of command line area (more space for messages/completions)

-- Window Splitting
o.splitbelow = true  -- Horizontal splits open below current window
o.splitright = true  -- Vertical splits open to the right of current window

-- Status Line
o.laststatus = 3  -- Global statusline (single statusline for all windows)

-- ================================
-- FILE HANDLING
-- ================================

-- Backup Files
o.backup = false       -- Don't create backup files (e.g., file~)
o.writebackup = false  -- Don't create temporary backup while saving

-- Persistent Undo
o.undofile = true  -- Save undo history to file (survives Neovim restarts)
                   -- Undo files stored in: ~/.local/state/nvim/undo/

-- ================================
-- INPUT DEVICES
-- ================================

-- Mouse Support
o.mouse = ""  -- Disable mouse completely (keyboard-first workflow)
              -- Set to "a" to enable mouse in all modes if preferred

-- ================================
-- SEARCH BEHAVIOR
-- ================================

-- Case Sensitivity
o.ignorecase = true  -- Ignore case in search patterns by default
                     -- Note: Use \C in pattern to force case-sensitive search

-- ================================
-- MESSAGES & NOTIFICATIONS
-- ================================

-- Suppress certain messages to reduce clutter
o.shortmess:append("c")  -- Don't show completion messages like "match 1 of 2"
