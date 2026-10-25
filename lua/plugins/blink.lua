return {{
    "saghen/blink.cmp",
    opts = function(_, opts)
        -- Ключевое: не показывать меню при входе в insert mode рядом с триггером
        opts.completion = opts.completion or {}
        opts.completion.trigger = opts.completion.trigger or {}
        opts.completion.trigger.show_on_insert_on_trigger_character = false

        -- Ваши настройки completion (остаются)
        opts.completion.list = {
            selection = {
                preselect = true,
                auto_insert = false
            }
        }
        opts.completion.trigger.show_on_keyword = true
        opts.completion.trigger.show_on_trigger_character = true
        opts.completion.trigger.prefetch_on_insert = true
        opts.completion.ghost_text = {
            enabled = true
        }

        -- Источники (без snippets, как вы хотели ранее)
        opts.sources.default = function()
            return {"lsp", "path", "buffer"}
        end

        -- Ваши keymap (без изменений)
        opts.keymap = {
            preset = "default",
            ["<Esc>"] = {"hide", "fallback"},
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
                preset = "default",
                ["<CR>"] = {"accept", "fallback"},
                ["<Up>"] = {"select_prev", "fallback"},
                ["<Down>"] = {"select_next", "fallback"}
            }
        }

        opts.snippets = {
            preset = "luasnip"
        }
    end
}}
