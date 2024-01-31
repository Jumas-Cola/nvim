local keymap = vim.keymap
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Trouble
keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
keymap.set("n", "<leader>xw",
           function() require("trouble").toggle("workspace_diagnostics") end)
keymap.set("n", "<leader>xd",
           function() require("trouble").toggle("document_diagnostics") end)
keymap.set("n", "<leader>xq",
           function() require("trouble").toggle("quickfix") end)
keymap.set("n", "<leader>xl",
           function() require("trouble").toggle("loclist") end)
keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

map("n", "<C-N>", ":bnext<CR>", opts)
map("n", "<C-P>", ":bprev<CR>", opts)

-- Neotree
map("n", "<Leader>t", ":Neotree toggle<CR>", opts)

-- Neoformat
map("n", "<Leader>p", ":Neoformat<CR>", opts)

-- Быстрое сохранение сессии
map("n", "<C-s>", ":mksession!<CR>", opts)

-- Move to previous/next
map("n", "<A-,>", ":tabprev<CR>", opts)
map("n", "<A-.>", ":tabnext<CR>", opts)
-- Close buffer
map("n", "<A-c>", ":tabc<CR>", opts)

-- Markdown preview
-- map("n", "<C-p>", ":MarkdownPreviewToggle<CR>", opts)

-- Изменение размера vertical split
map("n", "<A-[>", ":vertical resize +1<CR>", opts)
map("n", "<A-]>", ":vertical resize -1<CR>", opts)

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
keymap.set("n", "zR", require("ufo").openAllFolds)
keymap.set("n", "zM", require("ufo").closeAllFolds)
