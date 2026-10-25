return {{
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    dependencies = {"rafamadriz/friendly-snippets"},
    config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        -- Базовая инициализация LuaSnip с дефолтными настройками
        luasnip.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            ext_opts = {
                [types.insertNode] = {
                    unvisited = {
                        virt_text = {{"│", "Comment"}}, -- Используйте вертикальную черту или другой символ
                        virt_text_pos = "inline" -- Отображение внутри строки
                    }
                },
                [types.exitNode] = {
                    unvisited = {
                        virt_text = {{"│", "Comment"}},
                        virt_text_pos = "inline"
                    }
                }
            }
        })

        -- 1. Загружаем базовые friendly-snippets (из dependencies)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- 2. Загружаем ваши личные сниппеты с package.json
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = {vim.fn.stdpath("config") .. "/snippets"}
        })
    end
}}
