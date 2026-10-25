return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- Для JS/TS используем ESLint, если он настроен, иначе oxlint
            javascript = {"eslint", "oxlint"},
            typescript = {"eslint", "oxlint"},
            javascriptreact = {"eslint", "oxlint"},
            typescriptreact = {"eslint", "oxlint"},

            -- Для стилей — Prettier
            css = {"prettier"},
            scss = {"prettier"}
        },
        formatters = {
            prettier = {
                -- Принудительно 4 пробела
                prepend_args = {"--tab-width", "4", "--use-tabs", "false"}
            },
            eslint = {
                -- Эта настройка говорит conform, как запускать eslint
                command = "eslint",
                args = {"--fix", "--stdin", "--stdin-filename", "$FILENAME"},
                stdin = true
            },
            -- Настройка для Oxlint (если ты хочешь, чтобы он запускался с флагом --fix)
            oxlint = {
                command = "oxlint",
                args = {"--fix", "--stdin", "--stdin-filename", "$FILENAME"},
                stdin = true
            }
        }
    }
}
