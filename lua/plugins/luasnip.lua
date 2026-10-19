return {{
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    dependencies = {"rafamadriz/friendly-snippets"},
    config = function()
        local luasnip = require("luasnip")

        -- Базовая инициализация LuaSnip с дефолтными настройками
        luasnip.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI"
        })

        -- 1. Загружаем базовые friendly-snippets (из dependencies)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- 2. Загружаем ваши личные сниппеты с package.json
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = {vim.fn.stdpath("config") .. "/snippets"}
        })
    end
}}
