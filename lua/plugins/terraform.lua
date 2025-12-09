return {
  "hashivim/vim-terraform",
  ft = { "terraform", "tf", "tfvars" },

  config = function()
    -- Enable smart indentation
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

    -- Useful keymap: show plan preview (if terraform exists in path)
    vim.keymap.set("n", "<leader>tp", function()
      vim.cmd("!terraform plan")
    end, { desc = "Terraform Plan" })
  end,
}
