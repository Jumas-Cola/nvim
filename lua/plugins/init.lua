local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Пакетные менеджеры
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua", "shfmt"
                -- "flake8",
            }
        }
    }, {"williamboman/mason-lspconfig.nvim", opts = nil},
    -- Многофункциональный парсер
    "nvim-treesitter/nvim-treesitter",
    -- Поддержа blade
    "jwalton512/vim-blade",
    -- Автодополнялки
    "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ", {
        "Exafunction/codeium.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp"},
        config = function() require("codeium").setup({}) end
    }, "rafamadriz/friendly-snippets",
    -- Форматирование
    "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim",
    "sbdchd/neoformat",
    -- Автозакрытие парных элементов
    "hrsh7th/nvim-insx",
    -- Навигация по файлу в отдельном меню
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = {"Outline", "OutlineOpen"},
        keys = { -- Example mapping to toggle outline
            {"<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline"}
        },
        opts = {
            -- Your setup opts here
        }
    },
    -- Цветовые схемы
    {"catppuccin/nvim", name = "catppuccin"},
    -- Отображние уровня отступов чёрточками
    {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}},
    -- Дерево каталогов
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim", {
                "s1n7ax/nvim-window-picker",
                version = "2.*",
                config = function()
                    require("window-picker").setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = {
                                    "neo-tree", "neo-tree-popup", "notify"
                                },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = {"terminal", "quickfix"}
                            }
                        }
                    })
                end
            }
        },
        deactivate = function() vim.cmd([[Neotree close]]) end,
        init = function()
            if vim.fn.argc(-1) == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end
    }, -- Комментарии через gc
    {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end
    }, -- Нижняя информационная панель
    {"nvim-lualine/lualine.nvim"},
    -- Плагин для "оборачивания" в символы
    "tpope/vim-surround", "tpope/vim-repeat", -- Ставит ; и ,
    "lfilho/cosco.vim", -- Поиск по проекту
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {"nvim-lua/plenary.nvim"}
    }, -- Поддержка множества курсоров
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {'smoka7/hydra.nvim'},
        opts = {},
        cmd = {
            'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern',
            'MCunderCursor'
        },
        keys = {
            {
                mode = {'v', 'n'},
                '<C-n>',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor'
            }
        }
    }, -- Интеграция с git
    "lewis6991/gitsigns.nvim",
    -- Отображение цветов по кодам
    "norcalli/nvim-colorizer.lua",
    -- Подсветка одинаковых слов
    "RRethy/vim-illuminate",
    -- Иконки для автодополнения
    "onsails/lspkind.nvim", -- Notifications
    "rcarriga/nvim-notify", -- Подсветка TODO
    {"folke/todo-comments.nvim", dependencies = {{"nvim-lua/plenary.nvim"}}},
    -- Folds
    {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"},
    -- Подсветка ошибок
    {
        "folke/trouble.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    }
})
