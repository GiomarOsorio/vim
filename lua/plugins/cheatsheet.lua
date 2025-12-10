-- ============================================
-- Plugin: Custom CheatSheet
-- ============================================
-- Dynamic keymap reference in a beautiful floating window.
-- Shows all configured keybindings organized by category.
--
-- Features:
--   - Real-time keymap discovery from Neovim configuration
--   - Categorized keymaps (Files, Git, LSP, Debug, etc.)
--   - QWERTY and Dvorak Programming layout reference
--   - Beautiful bordered floating window
--   - Scrollable with j/k or t/n (Dvorak)
--   - Always up-to-date (dynamically generated)
--
-- Categories:
--   - Movement (QWERTY vs Dvorak comparison)
--   - Files and Buffers
--   - Search (Telescope)
--   - Windows and Splits
--   - LSP (Code navigation, actions)
--   - Diagnostics (Trouble)
--   - Git operations
--   - Debug (DAP)
--   - Terraform
--   - Terminal
--   - Help
--
-- Keymaps:
--   <leader>?     - Open CheatSheet
--   :CheatSheet   - Open CheatSheet command
--
-- Inside CheatSheet:
--   q / <Esc>     - Close
--   j/k or t/n    - Scroll up/down
--   <C-d>/<C-u>   - Page down/up
--   gg / G        - Top/Bottom
--
-- Implementation:
--   - Uses plenary.nvim as dependency
--   - Dynamically queries vim.api.nvim_get_keymap()
--   - Filters and categorizes by description patterns
--   - Formats in a bordered ASCII box
--
-- Plugin: Custom implementation (not a separate plugin)
-- Dependency: plenary.nvim

return {
  "nvim-lua/plenary.nvim",

  config = function()
    -- Static movement reference (QWERTY vs Dvorak)
    local static_movement = {
      "╔══════════════════════════════════════════════════════════════════════════════╗",
      "║                           NEOVIM CHEATSHEET - SRE                            ║",
      "║                              Leader = <Space>                                ║",
      "╠══════════════════════════════════════════════════════════════════════════════╣",
      "║                         MOVEMENT (QWERTY vs DVORAK)                          ║",
      "╠══════════════════════════════════════════════════════════════════════════════╣",
      "║  QWERTY    DVORAK     Action                                                 ║",
      "║  ───────── ───────── ─────────────────────────────────────────               ║",
      "║  h         h          Move left                                              ║",
      "║  j         t          Move down                                              ║",
      "║  k         n          Move up                                                ║",
      "║  l         s          Move right                                             ║",
      "║  ───────── ───────── ─────────────────────────────────────────               ║",
      "║  <leader>h <leader>h  Window left                                            ║",
      "║  <leader>j <leader>t  Window down                                            ║",
      "║  <leader>k <leader>n  Window up                                              ║",
      "║  <leader>l <leader>s  Window right                                           ║",
      "║  ───────── ───────── ─────────────────────────────────────────               ║",
      "║  <C-h>     <C-h>      Insert: Move left                                      ║",
      "║  <C-j>     <C-t>      Insert: Move down                                      ║",
      "║  <C-k>     <C-n>      Insert: Move up                                        ║",
      "║  <C-l>     <C-s>      Insert: Move right                                     ║",
      "╠══════════════════════════════════════════════════════════════════════════════╣",
      "║                     REMAPPED COMMANDS (Dvorak mode)                          ║",
      "╠══════════════════════════════════════════════════════════════════════════════╣",
      "║  fj / FJ     Till character / Till backwards (was: t/T)                      ║",
      "║  fl / fL     Next / Previous search (was: n/N)                               ║",
      "║  fk / FK     Substitute character / line (was: s/S)                          ║",
    }

    -- Categories for grouping keymaps
    local categories = {
      { name = "FILES", pattern = { "save", "close", "buffer", "file", "explorer", "tree" } },
      { name = "BUFFERLINE", pattern = { "buffer", "tab", "pin" } },
      { name = "SEARCH (Telescope)", pattern = { "find", "grep", "search", "telescope", "recent" } },
      { name = "WINDOWS", pattern = { "split", "window" } },
      { name = "LSP (Code)", pattern = { "definition", "declaration", "reference", "implementation", "rename", "action", "diagnostic", "format", "hover" } },
      { name = "DIAGNOSTICS (Trouble)", pattern = { "trouble", "quickfix", "symbol" } },
      { name = "GIT", pattern = { "git", "hunk", "blame", "diff", "lazygit", "stage", "reset" } },
      { name = "DEBUG (DAP)", pattern = { "debug", "breakpoint", "dap", "step", "continue" } },
      { name = "TERRAFORM", pattern = { "terraform" } },
      { name = "COMMENTS", pattern = { "comment" } },
      { name = "TERMINAL", pattern = { "terminal" } },
      { name = "HELP", pattern = { "cheatsheet", "help", "which" } },
    }

    -- Helper to pad string to fixed width
    local function pad_right(str, width)
      local len = vim.fn.strdisplaywidth(str)
      if len >= width then
        return str:sub(1, width)
      end
      return str .. string.rep(" ", width - len)
    end

    -- Helper to create a formatted line
    local function format_line(lhs, desc)
      local content = "  " .. pad_right(lhs, 14) .. desc
      return "║" .. pad_right(content, 78) .. "║"
    end

    -- Helper to create section header
    local function section_header(name)
      local padded = pad_right("  " .. name, 78)
      return {
        "╠══════════════════════════════════════════════════════════════════════════════╣",
        "║" .. padded .. "║",
        "╠══════════════════════════════════════════════════════════════════════════════╣",
      }
    end

    -- Get all keymaps and categorize them
    local function get_categorized_keymaps()
      local keymaps = vim.api.nvim_get_keymap("n")
      local categorized = {}
      local used = {}

      -- Initialize categories
      for _, cat in ipairs(categories) do
        categorized[cat.name] = {}
      end
      categorized["OTHER"] = {}

      -- Filter and categorize keymaps
      for _, km in ipairs(keymaps) do
        local desc = km.desc or ""
        local lhs = km.lhs or ""

        -- Skip keymaps without description or movement keys (handled statically)
        if desc == "" then goto continue end
        if desc:match("%[Dvorak%]") then goto continue end
        if lhs:match("^[hjkltns]$") and desc:match("Move") then goto continue end

        -- Find matching category
        local found = false
        for _, cat in ipairs(categories) do
          for _, pattern in ipairs(cat.pattern) do
            if desc:lower():match(pattern) or lhs:lower():match(pattern) then
              if not used[lhs] then
                table.insert(categorized[cat.name], { lhs = lhs, desc = desc })
                used[lhs] = true
                found = true
              end
              break
            end
          end
          if found then break end
        end

        -- Add to OTHER if no category matched
        if not found and not used[lhs] then
          table.insert(categorized["OTHER"], { lhs = lhs, desc = desc })
          used[lhs] = true
        end

        ::continue::
      end

      return categorized
    end

    -- Build the full cheatsheet content
    local function build_cheatsheet()
      local lines = {}

      -- Add static movement section
      for _, line in ipairs(static_movement) do
        table.insert(lines, line)
      end

      -- Get categorized keymaps
      local categorized = get_categorized_keymaps()

      -- Add each category
      for _, cat in ipairs(categories) do
        local keymaps = categorized[cat.name]
        if keymaps and #keymaps > 0 then
          -- Add section header
          for _, header_line in ipairs(section_header(cat.name)) do
            table.insert(lines, header_line)
          end
          -- Sort by lhs
          table.sort(keymaps, function(a, b) return a.lhs < b.lhs end)
          -- Add keymaps
          for _, km in ipairs(keymaps) do
            table.insert(lines, format_line(km.lhs, km.desc))
          end
        end
      end

      -- Add OTHER category if it has items
      if categorized["OTHER"] and #categorized["OTHER"] > 0 then
        for _, header_line in ipairs(section_header("OTHER")) do
          table.insert(lines, header_line)
        end
        table.sort(categorized["OTHER"], function(a, b) return a.lhs < b.lhs end)
        for _, km in ipairs(categorized["OTHER"]) do
          table.insert(lines, format_line(km.lhs, km.desc))
        end
      end

      -- Close the box
      table.insert(lines, "╚══════════════════════════════════════════════════════════════════════════════╝")

      return lines
    end

    -- Create :CheatSheet command
    vim.api.nvim_create_user_command("CheatSheet", function()
      -- Build content dynamically
      local content = build_cheatsheet()

      -- Create temporary buffer
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

      -- Configure buffer
      vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
      vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
      vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
      vim.api.nvim_set_option_value("filetype", "cheatsheet", { buf = buf })

      -- Calculate window size
      local width = 82
      local height = math.min(vim.o.lines - 4, #content + 2)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      -- Create floating window
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
        title = " CheatSheet ",
        title_pos = "center",
      })

      -- Keymaps to close
      local close_keys = { "q", "<Esc>", "<leader>?" }
      for _, key in ipairs(close_keys) do
        vim.keymap.set("n", key, function()
          vim.api.nvim_win_close(win, true)
        end, { buffer = buf, silent = true })
      end

      -- Navigation (QWERTY and Dvorak)
      vim.keymap.set("n", "j", "jzz", { buffer = buf, silent = true })
      vim.keymap.set("n", "k", "kzz", { buffer = buf, silent = true })
      vim.keymap.set("n", "t", "jzz", { buffer = buf, silent = true }) -- Dvorak
      vim.keymap.set("n", "n", "kzz", { buffer = buf, silent = true }) -- Dvorak
      vim.keymap.set("n", "<C-d>", "<C-d>zz", { buffer = buf, silent = true })
      vim.keymap.set("n", "<C-u>", "<C-u>zz", { buffer = buf, silent = true })
      vim.keymap.set("n", "gg", "gg", { buffer = buf, silent = true })
      vim.keymap.set("n", "G", "G", { buffer = buf, silent = true })
    end, { desc = "Show keymaps CheatSheet" })
    -- Global keymap (<leader>?) is centralized in lua/core/keymaps.lua
  end,
}
