require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"gopls",
		"html",
		"intelephense",
		"jsonls",
		"lua_ls",
		"phpactor",
		"psalm",
		"pyright",
		"sqlls",
		"tsserver",
		"volar",
		"yamlls",
	},
	automatic_installation = true,
})
