return {{
    "neovim/nvim-lspconfig",
    opts = {
        -- Настройки для конкретных серверов
        servers = {
            -- Если у вас дефолтный для LazyVim сервер vtsls:
            vtsls = {
                settings = {
                    typescript = {
                        -- Принудительно заставляем сервер индексировать внутренности файлов
                        documentSymbols = {
                            enabled = true
                        }
                    },
                    javascript = {
                        documentSymbols = {
                            enabled = true
                        }
                    }
                }
            },
            -- Если у вас старый/альтернативный ts_ls (бывший tsserver):
            ts_ls = {
                settings = {
                    javascript = {
                        implicitProjectConfig = {
                            checkJs = true
                        }
                    },
                    typescript = {
                        -- Разрешаем выдачу локальных переменных и внутренних функций в Outline
                        showUnused = true
                    }
                }
            }
        }
    }
},

-- Прокачиваем Snacks.picker, чтобы он гарантированно отображал типы, переменные и хуки в TSX
        {
    "folke/snacks.nvim",
    opts = {
        picker = {
            sources = {
                lsp_symbols = {
                    -- Белый список сущностей, которые Snacks разрешено забирать из TSX и выводить на экран
                    filter = {
                        default = {"Class", "Method", "Function", "Interface", "Variable", -- Ловит константы-компоненты const App = () => {}
                                   "Struct", "Enum", "Property", "Field"}
                    }
                }
            }
        }
    }
}}
