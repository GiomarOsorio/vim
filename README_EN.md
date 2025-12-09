<a href="README.md">
  <img src="https://img.shields.io/badge/lang-Español-green.svg" alt="Español">
</a>

# TurtleSRE Neovim Configuration

Professional Neovim configuration optimized for **SRE/DevOps**, with full support for Kubernetes, Terraform, Docker, and multi-language development.

## Screenshots

<p align="center">
  <img src="image/turtle dashboard.png" alt="TurtleSRE Dashboard" width="100%">
</p>

<p align="center">
  <img src="image/turtle dashboard 2.png" alt="TurtleSRE Dashboard 2" width="100%">
</p>

## System Requirements

- **Neovim** >= 0.9.0
- **Git** (required for lazy.nvim)
- **Make** and **GCC/Clang** (to compile telescope-fzf-native)

## Installation

### 1. Clone the repository

```bash
# Backup existing configuration (if any)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this configuration
git clone https://github.com/your-username/nvim.git ~/.config/nvim
```

### 2. Install system dependencies

#### Linux (Debian/Ubuntu)

```bash
# Basic dependencies
sudo apt update
sudo apt install -y \
    git \
    make \
    gcc \
    ripgrep \
    fd-find \
    xclip \
    xsel \
    curl \
    unzip

# Python
sudo apt install -y python3 python3-pip python3-venv
pip install pynvim flake8

# Node.js (via nvm - recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts
nvm use --lts

# pnpm (alternative to npm)
npm install -g pnpm
# or
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Global npm tools
pnpm install -g neovim eslint_d

# Go
sudo apt install -y golang-go
# or install from https://go.dev/dl/ for the latest version

# Additional tools
sudo apt install -y shellcheck

# fzf (optional but recommended)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# lazygit (optional but highly recommended)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
```

#### Linux (Fedora/RHEL)

```bash
# Basic dependencies
sudo dnf install -y \
    git \
    make \
    gcc \
    ripgrep \
    fd-find \
    xclip \
    xsel \
    curl \
    unzip \
    python3 \
    python3-pip \
    golang \
    ShellCheck

pip install pynvim flake8

# Node.js (via nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts

pnpm install -g neovim eslint_d

# lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
```

#### Linux (Arch)

```bash
sudo pacman -S --needed \
    git \
    make \
    gcc \
    ripgrep \
    fd \
    xclip \
    xsel \
    python \
    python-pip \
    python-pynvim \
    go \
    shellcheck \
    fzf \
    lazygit \
    npm

npm install -g pnpm neovim eslint_d
pip install flake8
```

#### macOS

```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Dependencies
brew install \
    neovim \
    git \
    ripgrep \
    fd \
    fzf \
    lazygit \
    node \
    pnpm \
    python@3 \
    go \
    shellcheck

# Python tools
pip3 install pynvim flake8

# npm tools
pnpm install -g neovim eslint_d

# Configure fzf
$(brew --prefix)/opt/fzf/install
```

### 3. Start Neovim

```bash
nvim
```

On first launch:
1. **lazy.nvim** will download and install all plugins automatically
2. **Mason** will install the configured LSP servers, formatters, and linters

### 4. Verify tool installation

Inside Neovim:
```vim
:Mason
```

Make sure the following tools are installed:

#### LSP Servers
- `ansiblels` - Ansible
- `bashls` - Bash/Shell
- `dockerls` - Dockerfile
- `eslint` - JavaScript/TypeScript linting
- `gopls` - Go
- `html` - HTML
- `jsonls` - JSON
- `lua_ls` - Lua
- `marksman` - Markdown
- `pyright` - Python
- `terraformls` - Terraform
- `tflint` - Terraform linting
- `ts_ls` - TypeScript/JavaScript
- `yamlls` - YAML (with K8s schemas)

#### Formatters
- `black` - Python
- `gofumpt` - Go
- `goimports` - Go imports
- `isort` - Python imports
- `prettier` - JS/TS/JSON/YAML/HTML
- `prettierd` - Prettier daemon
- `shfmt` - Shell/Bash
- `stylua` - Lua

#### Linters
- `eslint_d` - JavaScript/TypeScript
- `golangci-lint` - Go
- `ruff` - Python
- `shellcheck` - Shell/Bash
- `yamllint` - YAML

## Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock
├── lua/
│   ├── config.lua              # Configuration flags
│   ├── core/
│   │   ├── init.lua
│   │   ├── keymaps.lua         # Global keybindings
│   │   ├── lazy.lua            # lazy.nvim setup
│   │   └── options.lua         # Neovim options
│   ├── lsp/
│   │   ├── init.lua            # Automatic LSP loader
│   │   └── servers/            # Per-server configurations
│   │       ├── ansiblels.lua   # Ansible
│   │       ├── bashls.lua      # Bash/Shell
│   │       ├── dockerls.lua    # Dockerfile
│   │       ├── eslint.lua      # ESLint
│   │       ├── gopls.lua       # Go
│   │       ├── html.lua        # HTML
│   │       ├── jsonls.lua      # JSON
│   │       ├── lua_ls.lua      # Lua
│   │       ├── marksman.lua    # Markdown
│   │       ├── pyright.lua     # Python
│   │       ├── terraformls.lua # Terraform
│   │       ├── ts_ls.lua       # TypeScript/JavaScript
│   │       └── yamlls.lua      # YAML (K8s, Docker Compose, etc.)
│   ├── plugins/                # Plugin configuration
│   │   ├── cmp.lua             # Autocompletion
│   │   ├── conform.lua         # Formatting
│   │   ├── git.lua             # Git integration
│   │   ├── lint.lua            # Linting
│   │   ├── lsp.lua             # Central LSP configuration
│   │   ├── mason.lua           # Tool manager
│   │   ├── schemastore.lua     # JSON/YAML schemas
│   │   ├── telescope.lua       # Fuzzy finder
│   │   ├── treesitter.lua      # Syntax highlighting
│   │   ├── trouble.lua         # Diagnostics
│   │   └── ui.lua              # Theme and UI
│   └── utils.lua
└── README.md
```

## Keybindings

**Leader key**: `<Space>`

### General

| Keybinding | Description |
|------------|-------------|
| `<leader>w` | Save file |
| `<leader>q` | Close buffer |
| `<leader>e` | Toggle NvimTree |
| `<leader>h` | Clear search highlight |

### Search (Telescope)

| Keybinding | Description |
|------------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Search history |
| `<leader>fr` | Recent files |

### Git

| Keybinding | Description |
|------------|-------------|
| `<leader>gg` | Open LazyGit |
| `<leader>gs` | Git status |
| `<leader>gc` | Git commits |
| `<leader>gb` | Git branches |
| `<leader>gd` | Git diff |
| `<leader>hb` | Git blame line |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |

### LSP

| Keybinding | Description |
|------------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format file |

### Diagnostics (Trouble)

| Keybinding | Description |
|------------|-------------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Terraform

| Keybinding | Description |
|------------|-------------|
| `<leader>ti` | Terraform init |
| `<leader>tp` | Terraform plan |
| `<leader>ta` | Terraform apply |

### Windows/Splits

| Keybinding | Description |
|------------|-------------|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<C-h/j/k/l>` | Navigate between splits |

## Supported Languages

| Language | LSP | Formatter | Linter |
|----------|-----|-----------|--------|
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

## Special Features

### Kubernetes
- Automatic schema validation for K8s manifests
- Autocompletion for Kubernetes resources
- Helm charts support

### Terraform
- LSP with autocompletion
- Linting with tflint
- Auto-format on save
- Integrated commands (init, plan, apply)

### Git Integration
- **gitsigns**: Gutter indicators, inline blame
- **fugitive**: Native Git commands
- **diffview**: Advanced diff view
- **lazygit**: Complete Git TUI

## Troubleshooting

### Check Neovim health
```vim
:checkhealth
```

### Reinstall Mason tools
```vim
:MasonUpdate
```

### Update plugins
```vim
:Lazy sync
```

### Common issues

**Error: "No clipboard tool found"**
```bash
# Linux
sudo apt install xclip xsel

# macOS (already included)
```

**Error: "Node not found"**
```bash
# Verify installation
node --version
npm --version
```

**LSP not working**
1. Verify the server is installed: `:Mason`
2. Check logs: `:LspLog`
3. Restart LSP: `:LspRestart`

## Customization

### Enable GitHub Copilot
In `lua/config.lua`:
```lua
M.features = {
    copilot = true,  -- Change to true
}
```

### Change theme
In `lua/plugins/ui.lua`, modify the gruvbox configuration or install another theme.

### Add new LSP
1. Add it to the list in `lua/plugins/mason.lua`
2. Create configuration in `lua/lsp/servers/name.lua` (optional)

## Updates

```bash
cd ~/.config/nvim
git pull

# Inside Neovim
:Lazy sync
:MasonUpdate
```

## Dependencies Summary

### Quick install script (Linux Debian/Ubuntu)

```bash
#!/bin/bash

# System dependencies
sudo apt update && sudo apt install -y \
    git make gcc ripgrep fd-find xclip xsel \
    python3 python3-pip python3-venv \
    curl unzip shellcheck golang-go

# Python
pip install pynvim flake8

# Node.js via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# pnpm and npm tools
npm install -g pnpm
pnpm install -g neovim eslint_d

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit && sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz

echo "Installation complete. Run 'nvim' to start."
```

### Quick install script (macOS)

```bash
#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Dependencies
brew install neovim git ripgrep fd fzf lazygit node pnpm python@3 go shellcheck

# Python
pip3 install pynvim flake8

# npm
pnpm install -g neovim eslint_d

# fzf config
$(brew --prefix)/opt/fzf/install --all

echo "Installation complete. Run 'nvim' to start."
```

## License

MIT

---

**Author**: Giomar Osorio
**Last updated**: 2025
