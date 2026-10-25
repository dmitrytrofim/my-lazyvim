return {{
    "saghen/blink.cmp",
    opts = {
        snippets = {
            preset = "luasnip"
        },
        sources = {
            default = {"lsp", "path", "snippets", "buffer"}
        },
        keymap = {
            preset = "default",
            ["<Esc>"] = {"hide", "fallback"},

            -- НАСТРОЙКА ENTER: если меню открыто — только вставляем подсказку (без новой строки!)
            ["<CR>"] = {"accept", "fallback"},
            ["<Tab>"] = {"accept", "snippet_forward", "fallback"},
            ["<S-Tab>"] = {"snippet_backward", "select_prev", "fallback"},
            ["<C-l>"] = {"accept", "fallback"},

            -- Настройка стрелок для всех режимов
            ["<Up>"] = {"select_prev", "fallback"},
            ["<Down>"] = {"select_next", "fallback"},

            -- Навигация без отрыва рук (Home Row)
            ["<C-j>"] = {"select_next", "fallback"},
            ["<C-k>"] = {"select_prev", "fallback"}
        },
        cmdline = {
            enabled = true,
            keymap = {
                preset = "default",
                -- Дублируем настройки для командной строки
                ["<CR>"] = {"accept", "fallback"},
                ["<Up>"] = {"select_prev", "fallback"},
                ["<Down>"] = {"select_next", "fallback"}
            }
        },
        completion = {
            list = {
                selection = {
                    -- preselect автоматически подсвечивает первую подсказку в списке.
                    -- Вам не нужно нажимать Ctrl+j, чтобы выбрать её, можно сразу жать Tab!
                    preselect = true,
                    auto_insert = false
                }
            },
            trigger = {
                prefetch_on_insert = true,
                show_on_keyword = true,
                show_on_trigger_character = true
            },
            ghost_text = {
                enabled = true
            }
        }
    }
}}
