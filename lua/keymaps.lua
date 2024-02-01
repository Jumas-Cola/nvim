local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

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
