local insx = require("insx")

-- HTML
local html_filetypes = {
    "html", "javascript", "typescript", "javascriptreact", "typescriptreact",
    "svelte", "vue", "tsx", "jsx", "rescript", "xml", "php", "markdown",
    "astro", "glimmer", "handlebars", "hbs", "blade"
}

-- Замена тегов только для html файлов
insx.add(">", insx.with(require("insx.recipe.substitute")({
    pattern = [[<\(\w\+\).\{-}\%#]],
    replace = [[\0>\%#</\1>]]
}), {
    insx.with.filetype(html_filetypes), insx.with.nomatch(
        [[<\(area\|base\|br\|col\|command\|embed\|hr\|img\|slot\|input\|keygen\|link\|meta\|param\|source\|track\|wbr\|menuitem\)\%#]])
}))

-- Удаление тегов только для html файлов
insx.add("<BS>", insx.with(require("insx.recipe.substitute")({
    pattern = [[<\(\w\+\).\{-}>\%#</.\{-}>]],
    replace = [[\%#]]
}), {insx.with.filetype(html_filetypes)}))

require('insx.preset.standard').setup()
