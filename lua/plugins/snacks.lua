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
    }, -- Здесь теперь всё закрыто корректно, без синтаксического мусора
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
