local cmd = vim.cmd
local opt = vim.opt

require("catppuccin").setup({
    flavour = "mocha" -- latte, frappe, macchiato, mocha
})
cmd.colorscheme("catppuccin")

opt.guifont = "FiraCode Nerd Font"
