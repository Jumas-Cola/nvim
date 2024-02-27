local cmd = vim.cmd
local opt = vim.opt

local dracula = require("dracula")
dracula.setup({
	show_end_of_buffer = true, -- default false
	italic_comment = true, -- default false
})
cmd.colorscheme("dracula")

opt.guifont = "FiraCode Nerd Font"
