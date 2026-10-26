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
            delete_check_events = "TextChanged,TextChangedI",
            updateevents = "TextChanged,TextChangedI",
            ext_opts = {
                -- Настройка для обычных мест вставки ($1, $2 и т.д.)
                [types.insertNode] = {
                    -- passive показывает метку во всех точках, где сейчас НЕТ курсора
                    passive = {
                        virt_text = {{"│", "Comment"}},
                        virt_text_pos = "inline" -- Вставляет черту аккуратно между символами
                    }
                },
                -- Настройка для финальной точки выхода ($0)
                [types.exitNode] = {
                    -- Явно заставляем $0 тоже показывать метку, пока мы до неё не дошли
                    passive = {
                        virt_text = {{"│", "Comment"}},
                        virt_text_pos = "inline"
                    }
                }
            }
        })

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = {vim.fn.stdpath("config") .. "/snippets"}
        })
    end
}}
