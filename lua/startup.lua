local function getGitStatus()
	local handle = io.popen("git branch --show-current 2> /dev/null")
	local branch = handle:read("*a")
	handle:close()

	branch = string.gsub(branch, "\n", "")
	if branch == "" then
		return { "Не в репозитории Git" }
	end

	local handle = io.popen("git status --short 2> /dev/null")
	local status = handle:read("*a")
	handle:close()

	statusLines = {}
	if status == "" then
		statusLines = { "Нет изменений" }
	else
		for s in status:gmatch("[^\r\n]+") do
			table.insert(statusLines, s)
		end
	end

	return {
		"⎇ Git Branch",
		branch,
		"",
		"↪ Git Status",
		table.unpack(statusLines),
	}
end

local function showStartScreen()
	-- Очищаем экран и создаем новый буфер
	vim.cmd("enew")
	-- Устанавливаем параметры для буфера
	vim.bo[0].buftype = "nofile"
	vim.bo[0].bufhidden = "hide"
	vim.bo[0].swapfile = false

	local startScreenContent = {
		table.unpack(getGitStatus()),
	}

	vim.api.nvim_buf_set_lines(0, 0, -1, false, startScreenContent)

	vim.cmd("highlight StartupHighlightGroup guifg=#69fe94")

	vim.api.nvim_buf_add_highlight(0, -1, "StartupHighlightGroup", 1, 0, -1)

	local last_line_number = vim.api.nvim_buf_line_count(0)
	for i = 4, last_line_number do
		vim.api.nvim_buf_add_highlight(0, -1, "StartupHighlightGroup", i, 0, -1)
	end

	vim.cmd("normal gg")

	vim.cmd("Neotree toggle")

	vim.bo[0].modifiable = false
end

-- Прикрепляем к событию VimEnter, если Neovim запускается без файлов
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if #vim.fn.argv() == 0 then
			showStartScreen()
		end
	end,
})
