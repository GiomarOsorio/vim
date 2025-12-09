-- ==============================================
-- CheatSheet - View of all keymaps
-- Command: :CheatSheet or <leader>?
-- ==============================================

return {
  "nvim-lua/plenary.nvim", -- Already a dependency

  config = function()
    -- Cheatsheet content
    local cheatsheet_content = [[
╔══════════════════════════════════════════════════════════════════════════════╗
║                           NEOVIM CHEATSHEET - SRE                            ║
║                              Leader = <Space>                                ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                     ⌨️  MOVEMENT (QWERTY vs DVORAK)                          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  QWERTY    DVORAK     Action                                                 ║
║  ───────── ───────── ─────────────────────────────────────────               ║
║  h         h          Move left                                              ║
║  j         t          Move down                                              ║
║  k         n          Move up                                                ║
║  l         s          Move right                                             ║
║  ───────── ───────── ─────────────────────────────────────────               ║
║  <C-h>     <C-h>      Window left                                            ║
║  <C-j>     <C-t>      Window down                                            ║
║  <C-k>     <C-n>      Window up                                              ║
║  <C-l>     <C-s>      Window right                                           ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                     🔀 REMAPPED COMMANDS (Dvorak mode)                       ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  j / J       Till character / Till backwards (was: t/T)                      ║
║  l / L       Next / Previous search (was: n/N)                               ║
║  k / K       Substitute character / line (was: s/S)                          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              📁 FILES                                        ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>w      Save file                                                    ║
║  <leader>q      Close window                                                 ║
║  <leader>x      Close current buffer                                         ║
║  <leader>e      Toggle NvimTree (explorer)                                   ║
║  <Esc>          Clear search highlight                                       ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              📑 BUFFERLINE                                   ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <Tab>          Next buffer                                                  ║
║  <S-Tab>        Previous buffer                                              ║
║  <leader>1-9    Go to buffer by number                                       ║
║  <leader>bb     Pick buffer (select)                                         ║
║  <leader>bP     Pin/Unpin buffer                                             ║
║  <leader>bn     Move buffer right                                            ║
║  <leader>bp     Move buffer left                                             ║
║  <leader>bc     Pick buffer to close                                         ║
║  <leader>bC     Close other buffers                                          ║
║  <leader>bl     Close buffers to the left                                    ║
║  <leader>br     Close buffers to the right                                   ║
║  <leader>bs     Sort by directory                                            ║
║  <leader>bS     Sort by extension                                            ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🔍 SEARCH (Telescope)                           ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>ff     Find files                                                   ║
║  <leader>fg     Live grep (search text)                                      ║
║  <leader>fb     List buffers                                                 ║
║  <leader>fh     Search help                                                  ║
║  <leader>fo     Recent files                                                 ║
║  <leader>fd     Diagnostics                                                  ║
║  <leader>ft     Search TODOs                                                 ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🪟 WINDOWS                                      ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>sv     Vertical split                                               ║
║  <leader>sh     Horizontal split                                             ║
║  <leader>sx     Close window                                                 ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              📝 LSP (Code)                                   ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  gd             Go to definition                                             ║
║  gD             Go to declaration                                            ║
║  gr             View references                                              ║
║  gi             Go to implementation                                         ║
║  <leader>D      Type definition                                              ║
║  <leader>rn     Rename symbol                                                ║
║  <leader>ca     Code actions                                                 ║
║  <leader>f      Format file                                                  ║
║  [d / ]d        Previous/Next diagnostic                                     ║
║  <leader>dl     Diagnostics list                                             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🔴 DIAGNOSTICS (Trouble)                        ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>xx     Toggle diagnostics                                           ║
║  <leader>xX     Buffer diagnostics                                           ║
║  <leader>xs     Document symbols                                             ║
║  <leader>xl     LSP definitions/references                                   ║
║  <leader>xq     Quickfix list                                                ║
║  <leader>xt     TODOs list                                                   ║
║  [t / ]t        Previous/Next TODO                                           ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🌿 GIT                                          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>gg     LazyGit (full interface)                                     ║
║  <leader>gs     Git status                                                   ║
║  <leader>gc     Git commit                                                   ║
║  <leader>gp     Git push                                                     ║
║  <leader>gl     Git pull                                                     ║
║  <leader>gd     Git diff split                                               ║
║  <leader>gb     Git blame                                                    ║
║  <leader>gL     Git log                                                      ║
║  <leader>gv     Open Diffview                                                ║
║  <leader>gV     Close Diffview                                               ║
║  <leader>gh     File history                                                 ║
║  <leader>gH     Repo history                                                 ║
║  ────────────── Hunks (gitsigns) ──────────────                              ║
║  ]c / [c        Next/Previous hunk                                           ║
║  <leader>hs     Stage hunk                                                   ║
║  <leader>hr     Reset hunk                                                   ║
║  <leader>hS     Stage entire buffer                                          ║
║  <leader>hR     Reset entire buffer                                          ║
║  <leader>hp     Preview hunk                                                 ║
║  <leader>hb     Toggle inline blame                                          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🏗️  TERRAFORM                                   ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>tp     Run terraform plan                                           ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              💬 COMMENTS                                     ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  gcc            Comment/uncomment line                                       ║
║  gc             Comment selection (visual)                                   ║
║  gcap           Comment paragraph                                            ║
║  gb             Block comment                                                ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🔄 SURROUND                                     ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  cs"'           Change " to '                                                ║
║  ds"            Delete "                                                     ║
║  ysiw)          Surround word with ()                                        ║
║  yss)           Surround line with ()                                        ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🖥️  TERMINAL                                    ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <C-u>          Horizontal terminal                                          ║
║  <C-e>          Vertical terminal                                            ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              📌 AUTOCOMPLETION                               ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <Tab>          Next suggestion (in cmp menu)                                ║
║  <S-Tab>        Previous suggestion                                          ║
║  <CR>           Confirm selection                                            ║
║  <C-f>          Accept Copilot (if active)                                   ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              🎯 SELECTION (Treesitter)                       ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <CR>           Expand selection                                             ║
║  <S-CR>         Scope selection                                              ║
║  <BS>           Shrink selection                                             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              ❓ HELP                                         ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  <leader>?      This CheatSheet                                              ║
║  <leader>       Which-key (wait to see options)                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
]]

    -- Create :CheatSheet command
    vim.api.nvim_create_user_command("CheatSheet", function()
      -- Create temporary buffer
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(cheatsheet_content, "\n"))

      -- Configure buffer
      vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
      vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
      vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
      vim.api.nvim_set_option_value("filetype", "cheatsheet", { buf = buf })

      -- Calculate window size
      local width = 82
      local height = math.min(vim.o.lines - 4, 60)
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
      vim.keymap.set("n", "t", "jzz", { buffer = buf, silent = true })  -- Dvorak
      vim.keymap.set("n", "n", "kzz", { buffer = buf, silent = true })  -- Dvorak
      vim.keymap.set("n", "<C-d>", "<C-d>zz", { buffer = buf, silent = true })
      vim.keymap.set("n", "<C-u>", "<C-u>zz", { buffer = buf, silent = true })
      vim.keymap.set("n", "gg", "gg", { buffer = buf, silent = true })
      vim.keymap.set("n", "G", "G", { buffer = buf, silent = true })
    end, { desc = "Show keymaps CheatSheet" })

    -- Global keymap to open cheatsheet
    vim.keymap.set("n", "<leader>?", "<cmd>CheatSheet<cr>", { desc = "CheatSheet" })
  end,
}
