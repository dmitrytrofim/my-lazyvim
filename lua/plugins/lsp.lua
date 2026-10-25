return {{
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        -- Настройка hover-окна
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
            focusable = true
        })

        -- Безопасно объединяем настройки серверов
        opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
            -- Отключаем ругань на пустые CSS-классы
            cssls = {
                settings = {
                    css = {
                        lint = {
                            emptyRules = "ignore"
                        }
                    },
                    scss = {
                        lint = {
                            emptyRules = "ignore"
                        }
                    },
                    less = {
                        lint = {
                            emptyRules = "ignore"
                        }
                    }
                }
            },
            -- Твои настройки Emmet
            emmet_language_server = {
                init_options = {
                    showExpandedAbbreviation = "never",
                    showAbbreviationSuggestions = false
                }
            }
        })

        return opts
    end
}}
