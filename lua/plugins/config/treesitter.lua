require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c", "lua", "luadoc", "luap", "vim", "vimdoc", "query", "bash", "diff",
        "go", "html", "javascript", "jsdoc", "json", "jsonc", "markdown",
        "markdown_inline", "php", "phpdoc", "python", "regex", "toml", "tsx",
        "typescript", "yaml"
    }
}
