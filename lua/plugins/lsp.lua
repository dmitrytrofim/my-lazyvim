return {{
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
            focusable = true
        })

        opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
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
