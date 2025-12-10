-- ============================================
-- Plugin: vim-terraform (Terraform Enhancements)
-- ============================================
-- Terraform syntax highlighting, indentation, and formatting support.
-- Complements terraformls LSP server for complete Terraform development experience.
--
-- Features:
--   - Enhanced Terraform syntax highlighting
--   - Smart indentation and alignment
--   - Auto-format on save (terraform fmt)
--   - Module folding support
--   - Correct filetype detection (.tf, .tfvars)
--
-- Keymaps: See lua/core/keymaps.lua for <leader>tp (terraform plan)
--           See lua/lsp/servers/terraformls.lua for buffer-local keymaps
--
-- File Types:
--   - *.tf (Terraform configuration)
--   - *.tfvars (Terraform variables)
--
-- Note: Works with lsp/servers/terraformls.lua for LSP features
--       (completion, validation, hover documentation)
--
-- Plugin: vim-terraform
-- Repo: hashivim/vim-terraform

return {
  "hashivim/vim-terraform",
  ft = { "terraform", "tf", "tfvars" },

  config = function()
    -- Smart indentation and alignment
    vim.g.terraform_align = 1

    -- Enable terraform fmt on save
    vim.g.terraform_fmt_on_save = 1

    -- Optional: Enable cleaner module folding
    vim.g.terraform_fold_sections = 1

    -- Associate filetypes correctly for LSP and null-ls
    vim.filetype.add({
      extension = {
        tf = "terraform",
        tfvars = "terraform",
      },
    })
    -- Keymaps are centralized in lua/core/keymaps.lua
  end,
}
