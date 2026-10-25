return {{
    "L3MON4D3/LuaSnip",
    version = "*",
    build = "make install_jsregexp",
    dependencies = {"rafamadriz/friendly-snippets"},
    config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        luasnip.setup({
            history = true,
            -- Эта опция из LazyVim помогает убирать маркеры при изменении текста
            delete_check_events = "TextChanged,TextChangedI",
            updateevents = "TextChanged,TextChangedI",
            ext_opts = {
                [types.insertNode] = {
                    unvisited = {
                        virt_text = {{"│", "Comment"}},
                        virt_text_pos = "inline"
                    }
                },
                -- Оставляем настройку для exitNode, но делаем её пустой только для активного состояния,
                -- чтобы не было дубля, когда курсор на $0.
                -- Однако, если маркер нужен только для визуального обозначения мест ввода,
                -- а $0 не является местом ввода, можно оставить его без текста,
                -- но тогда нужно полагаться на delete_check_events для очистки.
                [types.exitNode] = {
                    -- Оставляем пустым, чтобы не дублировать, но TextChanged почистит остатки
                }
            }
        })

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = {vim.fn.stdpath("config") .. "/snippets"}
        })
    end
}}
