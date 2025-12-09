# Configuration Guide

This guide provides detailed information on customizing your TurtleSRE Neovim configuration.

## Table of Contents

1. [Configuration Files Overview](#configuration-files-overview)
2. [Basic Configuration](#basic-configuration)
3. [Enabling Optional Plugins](#enabling-optional-plugins)
4. [Customizing Keymaps](#customizing-keymaps)
5. [Adding New LSP Servers](#adding-new-lsp-servers)
6. [Customizing the UI](#customizing-the-ui)
7. [Adding Custom Formatters](#adding-custom-formatters)
8. [Adding Custom Linters](#adding-custom-linters)
9. [Modifying Existing Plugins](#modifying-existing-plugins)
10. [Performance Tuning](#performance-tuning)

---

## Configuration Files Overview

```
~/.config/nvim/
├── init.lua                 # Main entry point (rarely needs modification)
├── lua/
│   ├── config.lua          # PRIMARY USER CONFIGURATION FILE
│   ├── core/
│   │   ├── keymaps.lua     # Global keymaps
│   │   └── options.lua     # Vim options
│   ├── lsp/
│   │   └── servers/        # LSP server configurations
│   └── plugins/            # Plugin configurations
```

**Key Files to Customize:**
- `lua/config.lua` - Feature flags and global settings
- `lua/core/keymaps.lua` - Keyboard shortcuts
- `lua/plugins/*.lua` - Plugin-specific settings

---

## Basic Configuration

### File: `lua/config.lua`

This is your primary configuration file for toggling features:

```lua
-- Enable/disable GitHub Copilot
M.enable_copilot = false

-- Enable/disable Claude Code
M.enable_claudecode = false

-- Enable/disable Dashboard on startup
M.enable_dashboard = true

-- Default colorscheme
M.colorscheme = "gruvbox"

-- Debug mode
M.debug = false
```

**After changing these values, restart Neovim for changes to take effect.**

---

## Enabling Optional Plugins

### GitHub Copilot

1. Edit `lua/config.lua`:
   ```lua
   M.enable_copilot = true
   ```

2. Restart Neovim

3. Authenticate:
   ```vim
   :Copilot auth
   ```

4. Follow the browser authentication flow

### Claude Code

1. Install Claude Code CLI (follow Claude Code documentation)

2. Edit `lua/config.lua`:
   ```lua
   M.enable_claudecode = true
   ```

3. Restart Neovim

### Disabling the Dashboard

If you prefer to start with an empty buffer:

```lua
M.enable_dashboard = false
```

---

## Customizing Keymaps

### Adding Custom Keymaps

Edit `lua/core/keymaps.lua` and add your mappings at the end:

```lua
-- Custom user keymaps
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
```

### Keymap Function Reference

```lua
map(mode, lhs, rhs, opts)
```

- `mode`: "n" (normal), "i" (insert), "v" (visual), "x" (visual block)
- `lhs`: The key combination to trigger (left-hand side)
- `rhs`: The command or function to execute (right-hand side)
- `opts`: Options table, always include `{ desc = "Description" }` for which-key

### Examples

```lua
-- Normal mode: Open file explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Insert mode: Quick escape
map("i", "jk", "<Esc>", { desc = "Quick escape" })

-- Visual mode: Move lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Multiple modes
map({"n", "v"}, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
```

### Overriding Existing Keymaps

Simply redefine the same key in your custom section:

```lua
-- Override default save keymap
map("n", "<leader>w", ":wa<CR>", { desc = "Save all buffers" })
```

---

## Adding New LSP Servers

### Step 1: Install via Mason

Inside Neovim:
```vim
:Mason
```

- Search for your LSP server
- Press `i` to install

### Step 2: Create Configuration File

Create a new file: `lua/lsp/servers/servername.lua`

**Basic Template:**

```lua
-- lua/lsp/servers/servername.lua
local lsp_config = require("plugins.lsp")

return {
  on_attach = lsp_config.on_attach,
  capabilities = lsp_config.capabilities,
}
```

**Advanced Example (Rust):**

```lua
-- lua/lsp/servers/rust_analyzer.lua
local lsp_config = require("plugins.lsp")

return {
  on_attach = lsp_config.on_attach,
  capabilities = lsp_config.capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
```

**Example with Root Directory Pattern:**

```lua
-- lua/lsp/servers/denols.lua
local lsp_config = require("plugins.lsp")

return {
  on_attach = lsp_config.on_attach,
  capabilities = lsp_config.capabilities,
  root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
}
```

### Step 3: Restart Neovim

The LSP will auto-load via `lua/lsp/init.lua`.

---

## Customizing the UI

### Changing the Colorscheme

#### Option 1: Change to Another Installed Theme

Edit `lua/config.lua`:

```lua
M.colorscheme = "gruvbox"  -- or any other installed theme
```

#### Option 2: Install and Use a New Theme

1. Add the theme plugin to `lua/plugins/ui.lua`:

```lua
{
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,
    })
  end,
},
```

2. Update `lua/config.lua`:

```lua
M.colorscheme = "catppuccin"
```

### Customizing Gruvbox

Edit the Gruvbox setup in `lua/plugins/ui.lua`:

```lua
require("gruvbox").setup({
  contrast = "hard",        -- "soft", "medium", "hard"
  transparent_mode = true,  -- Transparent background
  italic = {
    strings = false,
    comments = true,
    operators = false,
    folds = true,
  },
  overrides = {
    -- Custom color overrides
    SignColumn = { bg = "#282828" },
  },
})
```

### Customizing Lualine

Edit the lualine configuration in `lua/plugins/ui.lua`:

```lua
require("lualine").setup({
  options = {
    theme = "gruvbox",
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
```

### Customizing Bufferline

Key options in `lua/plugins/ui.lua`:

```lua
require("bufferline").setup({
  options = {
    numbers = "ordinal",           -- Show buffer numbers
    close_command = "bdelete! %d",
    indicator = {
      style = "underline",         -- "icon", "underline", "none"
    },
    separator_style = "slant",     -- "slant", "thick", "thin", "slope"
    show_buffer_close_icons = true,
    diagnostics = "nvim_lsp",
  },
})
```

---

## Adding Custom Formatters

Edit `lua/plugins/conform.lua`:

### Add Formatter to Mason

First, ensure it's installed via Mason:

```vim
:Mason
```

Search and install (e.g., `prettier`, `black`, `stylua`)

### Configure Formatter

```lua
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    rust = { "rustfmt" },
    -- Add your custom formatter
    yaml = { "prettier" },
    markdown = { "prettier" },
  },
})
```

### Custom Formatter Configuration

```lua
require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
  formatters = {
    black = {
      prepend_args = { "--line-length", "100", "--fast" },
    },
  },
})
```

---

## Adding Custom Linters

Edit `lua/plugins/lint.lua`:

### Install Linter via Mason

```vim
:Mason
```

### Configure Linter

```lua
require("lint").linters_by_ft = {
  python = { "ruff", "mypy" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  sh = { "shellcheck" },
  -- Add your custom linter
  yaml = { "yamllint" },
  dockerfile = { "hadolint" },
}
```

### Configure Linter Timing

```lua
-- Run linters on save and text change
vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
```

---

## Modifying Existing Plugins

### Telescope Configuration

Edit `lua/plugins/telescope.lua`:

```lua
require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.6,
      },
    },
    file_ignore_patterns = { "node_modules", ".git/" },
  },
  pickers = {
    find_files = {
      hidden = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
})
```

### Treesitter Configuration

Edit `lua/plugins/treesitter.lua`:

```lua
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "vim", "python", "javascript", "typescript",
    "go", "rust", "bash", "yaml", "json", "toml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = { enable = true },
})
```

### NvimTree Configuration

Edit `lua/plugins/nvimtree.lua`:

```lua
require("nvim-tree").setup({
  view = {
    width = 35,
    side = "left",
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cache" },
  },
  git = {
    enable = true,
    ignore = false,
  },
})
```

---

## Performance Tuning

### Lazy Loading Plugins

Plugins are lazy-loaded by default. You can customize lazy loading in plugin specs:

```lua
-- Load on command
{
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit" },  -- Only load when :LazyGit is called
}

-- Load on keymap
{
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
  },
}

-- Load on event
{
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

-- Load immediately (use sparingly)
{
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
}
```

### Reduce Startup Time

Check startup time:
```vim
:Lazy profile
```

Disable plugins you don't use by adding `enabled = false`:

```lua
{
  "plugin-name",
  enabled = false,  -- Completely disable this plugin
}
```

### Optimize LSP

Disable unused LSP features in `lua/plugins/lsp.lua`:

```lua
vim.diagnostic.config({
  virtual_text = false,  -- Disable inline diagnostic text
  update_in_insert = false,
})
```

---

## Tips and Best Practices

1. **Always backup before major changes:**
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Test changes incrementally:**
   - Make one change at a time
   - Restart Neovim after each change
   - Check for errors with `:checkhealth`

3. **Use `:Lazy` to manage plugins:**
   - Update: `:Lazy sync`
   - Profile: `:Lazy profile`
   - Check status: `:Lazy`

4. **Check Mason for tool issues:**
   ```vim
   :Mason
   :MasonLog
   ```

5. **View LSP logs:**
   ```vim
   :LspLog
   :LspInfo
   ```

6. **Use protected calls for experimental features:**
   ```lua
   local ok, module = pcall(require, "module-name")
   if not ok then
     vim.notify("Module not found", vim.log.levels.WARN)
     return
   end
   ```

---

## Common Customization Recipes

### Add a Custom Command

```lua
vim.api.nvim_create_user_command("FormatJson", function()
  vim.cmd("%!jq .")
end, { desc = "Format JSON with jq" })
```

### Add Auto-command for Specific Filetype

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "88"
  end,
})
```

### Add Custom Diagnostic Signs

```lua
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
```

---

## Getting Help

- Check `:help` for Neovim documentation
- Plugin documentation: `:help plugin-name`
- Lazy.nvim help: `:help lazy.nvim`
- LSP help: `:help lspconfig`
- Open an issue on GitHub for configuration-specific questions

---

**Last Updated:** December 2025
**Maintainer:** Giomar Osorio
