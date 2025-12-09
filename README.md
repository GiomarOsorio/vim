<a href="README_EN.md">
  <img src="https://img.shields.io/badge/lang-English-blue.svg" alt="English">
</a>

# TurtleSRE Neovim Configuration

Professional Neovim configuration optimized for **SRE/DevOps/Backend** engineers, featuring comprehensive support for Kubernetes, Terraform, Docker, and modern development workflows.

<p align="center">
  <img src="image/turtle dashboard.png" alt="TurtleSRE Dashboard" width="100%">
</p>

## Highlights

- **Dual Keyboard Layout Support**: Native QWERTY and Dvorak Programming layouts
- **SRE-Focused Tooling**: Kubernetes, Terraform, Docker, Ansible
- **Modern Development Stack**: LSP, DAP debugging, autocompletion, linting, formatting
- **Dynamic CheatSheet**: Auto-generated keymap reference with `:CheatSheet` command
- **Git Integration**: LazyGit, Fugitive, Gitsigns, Diffview
- **Professional UI**: Gruvbox theme with custom Lualine and Bufferline
- **Conditional Plugins**: Optional Copilot and Claude Code support
- **Lazy Loading**: Optimized startup performance with lazy.nvim

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Quick Start](#quick-start)
3. [Installation](#installation)
4. [Project Structure](#project-structure)
5. [Configuration](#configuration)
6. [Features](#features)
7. [Keybindings](#keybindings)
8. [Supported Languages](#supported-languages)
9. [Troubleshooting](#troubleshooting)
10. [Advanced Customization](#advanced-customization)

---

## System Requirements

- **Neovim** >= 0.9.0 (v0.11+ recommended)
- **Git** >= 2.0
- **Node.js** >= 18.0 (via nvm recommended)
- **Python** >= 3.8 with `pynvim`
- **Go** >= 1.20 (optional, for Go development)
- **ripgrep** (for Telescope live grep)
- **fd** (for fast file finding)

---

## Quick Start

### One-Line Install (Debian/Ubuntu)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/your-username/nvim/main/install.sh)
```

### Manual Quick Start

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone repository
git clone https://github.com/your-username/nvim.git ~/.config/nvim

# Start Neovim (plugins install automatically)
nvim
```

On first launch, **lazy.nvim** installs all plugins automatically, and **Mason** installs LSP servers and tools.

---

## Installation

### 1. System Dependencies

<details>
<summary><b>Linux (Debian/Ubuntu)</b></summary>

```bash
# Core dependencies
sudo apt update && sudo apt install -y \
    git make gcc g++ \
    ripgrep fd-find \
    xclip xsel \
    curl unzip

# Python environment
sudo apt install -y python3 python3-pip python3-venv
pip install pynvim flake8 black isort ruff

# Node.js via nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts
npm install -g pnpm
pnpm install -g neovim eslint_d prettier

# Go (optional)
sudo apt install -y golang-go

# Additional tools
sudo apt install -y shellcheck
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# LazyGit (highly recommended)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz
```
</details>

<details>
<summary><b>Linux (Arch)</b></summary>

```bash
sudo pacman -S --needed \
    neovim git base-devel \
    ripgrep fd xclip \
    python python-pip python-pynvim \
    nodejs npm go \
    shellcheck fzf lazygit

npm install -g pnpm neovim eslint_d prettier
pip install flake8 black isort ruff
```
</details>

<details>
<summary><b>macOS</b></summary>

```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install neovim git ripgrep fd fzf lazygit \
    node pnpm python@3 go shellcheck

# Python tools
pip3 install pynvim flake8 black isort ruff

# Node tools
pnpm install -g neovim eslint_d prettier

# Configure fzf
$(brew --prefix)/opt/fzf/install
```
</details>

### 2. Install Configuration

```bash
# Clone repository
git clone https://github.com/your-username/nvim.git ~/.config/nvim

# Start Neovim
nvim
```

### 3. Verify Installation

Inside Neovim, run:

```vim
:checkhealth
:Mason
```

Ensure all required LSP servers, formatters, and linters are installed. If any are missing, install them via `:Mason`.

---

## Project Structure

```
~/.config/nvim/
├── init.lua                      # Entry point - loads core modules
├── lazy-lock.json                # Plugin version lock file
├── lua/
│   ├── config.lua                # User configuration flags (Copilot, Dashboard, etc.)
│   │
│   ├── core/                     # Core Neovim configuration
│   │   ├── init.lua              # Core module loader
│   │   ├── options.lua           # Neovim options (line numbers, tabs, etc.)
│   │   ├── keymaps.lua           # Global keybindings (QWERTY + Dvorak)
│   │   └── lazy.lua              # lazy.nvim plugin manager setup
│   │
│   ├── lsp/                      # LSP configuration
│   │   ├── init.lua              # Auto-loader for LSP servers
│   │   └── servers/              # Individual LSP server configs
│   │       ├── ansiblels.lua     # Ansible Language Server
│   │       ├── bashls.lua        # Bash Language Server
│   │       ├── dockerls.lua      # Dockerfile Language Server
│   │       ├── gopls.lua         # Go Language Server
│   │       ├── jsonls.lua        # JSON Language Server (with schemas)
│   │       ├── lua_ls.lua        # Lua Language Server
│   │       ├── pyright.lua       # Python Language Server
│   │       ├── terraformls.lua   # Terraform Language Server
│   │       ├── ts_ls.lua         # TypeScript/JavaScript Language Server
│   │       └── yamlls.lua        # YAML Language Server (K8s schemas)
│   │
│   ├── plugins/                  # Plugin configurations
│   │   ├── cheatsheet.lua        # Dynamic CheatSheet command
│   │   ├── cmp.lua               # Autocompletion (nvim-cmp)
│   │   ├── conform.lua           # Code formatting (conform.nvim)
│   │   ├── dap.lua               # Debug Adapter Protocol
│   │   ├── git.lua               # Git integration (Fugitive, Gitsigns, Diffview, LazyGit)
│   │   ├── kubernetes.lua        # Kubernetes tools
│   │   ├── lint.lua              # Linting (nvim-lint)
│   │   ├── lsp.lua               # LSP core configuration
│   │   ├── mason.lua             # LSP/tool installer
│   │   ├── nvimtree.lua          # File explorer
│   │   ├── schemastore.lua       # JSON/YAML schema support
│   │   ├── telescope.lua         # Fuzzy finder
│   │   ├── terraform.lua         # Terraform tools
│   │   ├── treesitter.lua        # Syntax highlighting
│   │   ├── trouble.lua           # Diagnostics viewer
│   │   ├── ui.lua                # Theme, Lualine, Bufferline, Dashboard
│   │   ├── which-key.lua         # Keymap hints
│   │   └── conditional/          # Optional plugins
│   │       ├── copilot.lua       # GitHub Copilot (if enabled)
│   │       └── claudecode.lua    # Claude Code (if enabled)
│   │
│   └── utils.lua                 # Utility functions
│
└── README.md                     # This file
```

---

## Configuration

### Main Configuration File: `lua/config.lua`

This file controls feature flags and global settings:

```lua
-- Enable/disable GitHub Copilot
M.enable_copilot = false

-- Enable/disable Claude Code AI assistant
M.enable_claudecode = false

-- Enable/disable Dashboard on startup
M.enable_dashboard = true

-- Default colorscheme
M.colorscheme = "gruvbox"

-- General debugging option
M.debug = false
```

**To enable Copilot**: Change `enable_copilot` to `true` and restart Neovim, then authenticate with `:Copilot auth`.

**To enable Claude Code**: Change `enable_claudecode` to `true` and restart Neovim.

---

## Features

### Keyboard Layout Support

This configuration natively supports both **QWERTY** and **Dvorak Programming** keyboard layouts:

| Action | QWERTY | Dvorak Programming |
|--------|--------|-------------------|
| Move left | `h` | `h` |
| Move down | `j` | `t` |
| Move up | `k` | `n` |
| Move right | `l` | `s` |

**Dvorak remappings** for displaced keys:
- `fj` / `FJ` - Till character (original `t` / `T`)
- `fl` / `fL` - Next/previous search (original `n` / `N`)
- `fk` / `FK` - Substitute character/line (original `s` / `S`)

### Language Server Protocol (LSP)

Full LSP support with auto-configuration for:
- **Python**: `pyright` with formatting (black, isort) and linting (ruff)
- **Go**: `gopls` with formatting (gofumpt, goimports) and linting (golangci-lint)
- **JavaScript/TypeScript**: `ts_ls` with formatting (prettier) and linting (eslint_d)
- **Lua**: `lua_ls` with formatting (stylua)
- **Bash/Shell**: `bashls` with formatting (shfmt) and linting (shellcheck)
- **YAML**: `yamlls` with Kubernetes schemas
- **JSON**: `jsonls` with schema validation
- **Terraform**: `terraformls` with tflint
- **Docker**: `dockerls`
- **Ansible**: `ansiblels`
- **Markdown**: `marksman`

### Debug Adapter Protocol (DAP)

Debugging support for:
- **Bash**: bash-debug-adapter
- **JavaScript/TypeScript**: js-debug-adapter
- **Python**: debugpy (add manually via Mason)
- **Go**: delve (add manually via Mason)

### Git Integration

Four-level Git integration:
1. **Gitsigns**: Inline blame, hunk staging/unstaging, diff indicators
2. **Fugitive**: Native Git commands (`:Git`, `:Git blame`, etc.)
3. **Diffview**: Advanced diff and merge tool
4. **LazyGit**: Full-featured Git TUI

### Kubernetes

- Schema validation for Kubernetes manifests
- Autocompletion for K8s resources (apiVersion, kind, metadata, spec)
- Support for Helm charts, Kustomize, and custom CRDs

### Terraform

- LSP autocompletion and validation
- Auto-formatting on save
- Integrated commands: `<leader>ti` (init), `<leader>tp` (plan), `<leader>ta` (apply)
- Linting with tflint

### CheatSheet

Dynamic keymap viewer accessible via:
- Command: `:CheatSheet`
- Keymap: `<leader>?`

Automatically displays all configured keybindings organized by category (Files, Git, LSP, Debugging, etc.).

### Dashboard

TurtleSRE-themed dashboard with quick actions:
- `n` - New file
- `e` - Open file explorer
- `f` - Find files
- `r` - Recent files

---

## Keybindings

**Leader key**: `<Space>`

### General

| Keymap | Description |
|--------|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Quit window |
| `<leader>x` | Close buffer (smart close with NvimTree handling) |
| `<Esc>` | Clear search highlight |
| `ff` | New buffer |
| `<leader>?` | Open CheatSheet |

### File Explorer (NvimTree)

| Keymap | Description |
|--------|-------------|
| `<leader>e` | Toggle file explorer |
| `<C-n>` | Toggle file explorer |

### Buffers (Bufferline)

| Keymap | Description |
|--------|-------------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>1-9` | Jump to buffer 1-9 |
| `<leader>bb` | Pick buffer |
| `<leader>bc` | Pick buffer to close |
| `<leader>bC` | Close other buffers |
| `<leader>bP` | Pin/unpin buffer |
| `<leader>bn` | Move buffer right |
| `<leader>bp` | Move buffer left |

### Search (Telescope)

| Keymap | Description |
|--------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fo` | Recent files |
| `<leader>fd` | Diagnostics |

### LSP

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format file |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Git

| Keymap | Description |
|--------|-------------|
| `<leader>gg` | Open LazyGit |
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git pull |
| `<leader>gd` | Git diff split |
| `<leader>gb` | Git blame |
| `<leader>gL` | Git log |
| `<leader>gv` | Open Diffview |
| `<leader>gh` | File history |
| `<leader>hb` | Toggle line blame |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `]c` | Next hunk |
| `[c` | Previous hunk |

### Debugging (DAP)

| Keymap | Description |
|--------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue / Start debugging |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression |

### Diagnostics (Trouble)

| Keymap | Description |
|--------|-------------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |

### Terraform

| Keymap | Description |
|--------|-------------|
| `<leader>ti` | Terraform init |
| `<leader>tp` | Terraform plan |
| `<leader>ta` | Terraform apply |

### Windows/Splits

| Keymap | Description |
|--------|-------------|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>sx` | Close split |
| `<leader>h` | Focus left window |
| `<leader>j` | Focus down window |
| `<leader>k` | Focus up window |
| `<leader>l` | Focus right window |

---

## Supported Languages

| Language | LSP Server | Formatter | Linter |
|----------|-----------|-----------|--------|
| Python | pyright | black, isort | ruff |
| Go | gopls | gofumpt, goimports | golangci-lint |
| JavaScript/TypeScript | ts_ls | prettierd | eslint_d |
| Lua | lua_ls | stylua | - |
| Bash/Shell | bashls | shfmt | shellcheck |
| YAML | yamlls | prettier | yamllint |
| JSON | jsonls | prettier | - |
| HTML | html | prettier | - |
| Dockerfile | dockerls | - | - |
| Terraform | terraformls | terraform fmt | tflint |
| Markdown | marksman | prettier | - |
| Ansible | ansiblels | - | - |

---

## Troubleshooting

### Check Neovim Health

```vim
:checkhealth
```

This command diagnoses issues with providers, clipboard, LSP, and more.

### Common Issues

<details>
<summary><b>LSP not working</b></summary>

1. Verify server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. View logs: `:LspLog`
4. Restart LSP: `:LspRestart`
</details>

<details>
<summary><b>Clipboard not working</b></summary>

**Linux**: Install `xclip` or `xsel`
```bash
sudo apt install xclip xsel
```

**macOS**: Clipboard works natively
</details>

<details>
<summary><b>Telescope live grep not working</b></summary>

Install `ripgrep`:
```bash
# Ubuntu/Debian
sudo apt install ripgrep

# macOS
brew install ripgrep
```
</details>

<details>
<summary><b>Formatters/linters not running</b></summary>

1. Check if tool is installed: `:Mason`
2. Check conform/lint config in `lua/plugins/conform.lua` and `lua/plugins/lint.lua`
3. Manually format: `<leader>f`
</details>

### Update Configuration

```bash
cd ~/.config/nvim
git pull
```

Inside Neovim:
```vim
:Lazy sync
:MasonUpdate
```

---

## Advanced Customization

### Adding a New LSP Server

1. Install via Mason: `:Mason` → search → `i` to install
2. Create config file: `lua/lsp/servers/servername.lua`
3. Add basic configuration:

```lua
-- lua/lsp/servers/servername.lua
local lsp_config = require("plugins.lsp")

return {
  on_attach = lsp_config.on_attach,
  capabilities = lsp_config.capabilities,
  -- Server-specific settings
  settings = {
    -- ...
  }
}
```

4. The server will auto-load via `lua/lsp/init.lua`

### Changing Theme

Edit `lua/plugins/ui.lua` and replace the Gruvbox plugin with your preferred theme, or modify Gruvbox settings:

```lua
require("gruvbox").setup({
  contrast = "hard",        -- soft, medium, hard
  transparent_mode = true,  -- Enable transparency
})
```

### Adding Custom Keymaps

Edit `lua/core/keymaps.lua` and add your keymaps:

```lua
map("n", "<leader>custom", ":CustomCommand<CR>", { desc = "My custom command" })
```

### Disabling Dashboard

Edit `lua/config.lua`:

```lua
M.enable_dashboard = false
```

---

## License

MIT

---

**Author**: Giomar Osorio
**Version**: 2.0
**Last Updated**: December 2025

For questions or issues, please open an issue on GitHub.
