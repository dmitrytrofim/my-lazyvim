return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- Для JS/TS используем ESLint, если он настроен, иначе oxlint
            javascript = {"eslint"},
            typescript = {"eslint"},
            javascriptreact = {"eslint"},
            typescriptreact = {"eslint"},

            -- Для стилей — Prettier
            css = {"prettier"},
            scss = {"prettier"},
            html = {"prettier"}
        },
        formatters = {
            prettier = {
                -- Принудительно 4 пробела
                prepend_args = {"--tab-width", "4", "--use-tabs", "false", "--html-whitespace-sensitivity", "ignore",
                                "--bracket-same-line"}
            }
        }
    }
}
