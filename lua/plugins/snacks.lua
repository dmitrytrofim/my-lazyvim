return { -- 1. Бан для старого аутлайна
{
    "folke/snacks.nvim",
    opts = {
        scroll = {
            enabled = false
        },
        indent = {
            enabled = true,
            animate = {
                enabled = false
            },
            indent = {
                enabled = false
            },
            scope = {
                enabled = true,
                char = "│"
            }
        },
        scope = {
            enabled = true
        },
        picker = {
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = {
                            "focus_list",
                            mode = {"i", "n"}
                        }
                    }
                },
                list = {
                    keys = {
                        ["o"] = "confirm"
                        -- ["i"] = "focus_input" <-- Строку не удалил, а закомментировал, 
                        -- так как теперь мы принудительно внедряем её в config ниже
                    }
                }
            },
            sources = {
                explorer = {
                    hidden = true,
                    focus = "list",
                    auto_close = true,
                    jump = {
                        close = true
                    },
                    cwd = true,
                    layout = {
                        preset = "sidebar"
                    },
                    win = {
                        list = {
                            keys = {
                                -- Обе стрелки вызывают confirm строго внутри проводника проекта
                                ["<Right>"] = "confirm",
                                ["<Left>"] = "explorer_close",
                                ["<S-Left>"] = "explorer_close_all"
                            }
                        }
                    }
                }
            }
        }
    },
    -- ДОБАВЛЯЕМ БЛОК CONFIG:
    config = function(_, opts)
        -- Железобетонно внедряем маппинг уже в готовую таблицу opts перед запуском Snacks
        opts.picker = opts.picker or {}
        opts.picker.win = opts.picker.win or {}
        opts.picker.win.list = opts.picker.win.list or {}
        opts.picker.win.list.keys = opts.picker.win.list.keys or {}

        -- Запускаем плагин с обновленными настройками
        require("snacks").setup(opts)
    end,
    keys = {{
        "<leader>fe",
        function()
            if Snacks and Snacks.picker and Snacks.picker.explorer then
                Snacks.picker.explorer({
                    enter = true
                })
            end
        end,
        desc = "Explorer"
    }, {
        "<leader>ff",
        function()
            Snacks.picker.files()
        end,
        desc = "Find Files (Project Root)"
    }, {
        "<leader>fF",
        function()
            Snacks.picker.files({
                cwd = vim.fn.expand("%:p:h"),
                title = "Files in Current Dir"
            })
        end,
        desc = "Find Files (Current Directory)"
    }, -- ИДЕАЛЬНЫЙ НАВИГАТОР: Вытягивает структуру через Tree-sitter
    {
        "gO",
        function()
            Snacks.picker.lsp_symbols({
                layout = {
                    preset = "sidebar",
                    side = "right"
                },
                focus = "list",
                win = {
                    list = {
                        keys = {
                            ["l"] = "confirm"
                        }
                    }
                }
            })
        end,
        desc = "Structure Outline (LSP)"
    }}
}}
