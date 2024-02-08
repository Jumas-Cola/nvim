local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map("n", "<C-N>", ":bnext<CR>", opts)
map("n", "<C-P>", ":bprev<CR>", opts)

-- Neotree
map("n", "<Leader>t", ":Neotree toggle<CR>",
    {table.unpack(opts), desc = "Toggle Neotree"})

-- Neoformat
map("n", "<Leader>p", ":Neoformat<CR>",
    {table.unpack(opts), desc = "Prettify buffer"})

-- Быстрое сохранение сессии
map("n", "<C-s>", ":mksession!<CR>",
    {table.unpack(opts), desc = "Save vim session"})

-- Move to previous/next
map("n", "<A-,>", ":tabprev<CR>", {table.unpack(opts), desc = "Previous tab"})
map("n", "<A-.>", ":tabnext<CR>", {table.unpack(opts), desc = "Next tab"})

-- Close buffer
map("n", "<A-c>", ":tabc<CR>", {table.unpack(opts), desc = "Close buffer"})

-- Markdown preview
-- map("n", "<C-p>", ":MarkdownPreviewToggle<CR>", {table.unpack(opts), desc = "Markdown preview"})

-- Изменение размера vertical split
map("n", "<A-[>", ":vertical resize +1<CR>",
    {table.unpack(opts), desc = "Move splitline +1"})
map("n", "<A-]>", ":vertical resize -1<CR>",
    {table.unpack(opts), desc = "Move splitline -1"})

map("n", "<A-d>", ":tab split<CR>", {table.unpack(opts), desc = "Duplicate tab"})
