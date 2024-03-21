-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local autocmd = vim.api.nvim_create_autocmd
local lspconfig = require("lspconfig")
-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig/util")
local path = util.path

-- Подсветка одинаковых переменных
local function highlight_symbol(event)
	local id = vim.tbl_get(event, "data", "client_id")
	local client = id and vim.lsp.get_client_by_id(id)
	if client == nil or not client.supports_method("textDocument/documentHighlight") then
		return
	end

	local group = vim.api.nvim_create_augroup("highlight_symbol", { clear = false })

	vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = group,
		buffer = event.buf,
		callback = vim.lsp.buf.clear_references,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

autocmd("LspAttach", { desc = "Setup highlight symbol", callback = highlight_symbol })

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 250,
}

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end

	-- Fallback to system Python.
	return exepath("python3") or exepath("python") or "python"
end

lspconfig.pyright.setup({
	filetypes = { "python" },
	root_dir = lspconfig.util.root_pattern(
		"pyproject.toml",
		"setup.py",
		"main.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json"
	),
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_path(config.root_dir)
	end,
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
-- lspconfig.intelephense.setup({
lspconfig.phpactor.setup({
	filetypes = { "php" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.psalm.setup({
	filetypes = { "php" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.html.setup({
	filetypes = { "html", "blade" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.eslint.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"json",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "package-lock.json"),
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.tsserver.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.yamlls.setup({
	filetypes = { "yaml" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.jsonls.setup({
	filetypes = { "json", "jsonc" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.gopls.setup({
	filetypes = { "go", "gomod" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.volar.setup({
	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"json",
	},
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.sqlls.setup({
	filetypes = { "sql" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.lua_ls.setup({
	filetypes = { "lua" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
lspconfig.cssls.setup({
	filetypes = { "css", "scss", "sass" },
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
		"blade",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})
