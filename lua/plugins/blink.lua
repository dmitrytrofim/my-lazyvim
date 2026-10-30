return {{
    "saghen/blink.cmp",
    opts = function(_, opts)
        -- Меню не появляется при входе в insert mode рядом с триггером (>, <, и т.п.)
        opts.completion = opts.completion or {}
        opts.completion.trigger = opts.completion.trigger or {}
        opts.completion.trigger.show_on_insert_on_trigger_character = false

        -- Источники — как было изначально, со snippets
        opts.sources = opts.sources or {}
        opts.sources.default = {"lsp", "path", "snippets", "buffer"}

        opts.snippets = {
            preset = "luasnip"
        }

        opts.keymap = {
            preset = "default",
            -- ИСПРАВЛЕНО: При нажатии <Esc> сначала принудительно очищаем сниппет, затем скрываем меню
            ["<Esc>"] = {function()
                local ok, luasnip = pcall(require, "luasnip")
                if ok then
                    luasnip.unlink_current()
                end
            end, "hide", "fallback"},
            ["<CR>"] = {"accept", "fallback"},
            ["<Tab>"] = {"accept", "snippet_forward", "fallback"},
            ["<S-Tab>"] = {"snippet_backward", "select_prev", "fallback"},
            ["<C-l>"] = {"accept", "fallback"},
            ["<Up>"] = {"select_prev", "fallback"},
            ["<Down>"] = {"select_next", "fallback"},
            ["<C-j>"] = {"select_next", "fallback"},
            ["<C-k>"] = {"select_prev", "fallback"}
        }

        opts.cmdline = {
            enabled = true,
            keymap = {
                preset = "cmdline",
                ["<CR>"] = {"accept", "fallback"},
                ["<Up>"] = {"select_prev", "fallback"},
                ["<Down>"] = {"select_next", "fallback"},
                ["<Right>"] = {"accept", "fallback"}
            }
        }

        opts.completion.list = {
            selection = {
                preselect = true,
                auto_insert = false
            }
        }

        opts.completion.trigger.prefetch_on_insert = true
        opts.completion.trigger.show_on_keyword = true
        opts.completion.trigger.show_on_trigger_character = true
        opts.completion.ghost_text = {
            enabled = true
        }
    end
}}
