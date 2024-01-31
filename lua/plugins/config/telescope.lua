local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})
map("n", "<leader>ft", ":TodoTelescope keywords=TODO,FIX<CR>", {})
