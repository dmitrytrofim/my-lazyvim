return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Базовый JavaScript и TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        
        -- Полная поддержка React (JSX / TSX)
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        
        -- Расширенная поддержка JSON (включая файлы с комментариями .jsonc и json5)
        json = { "prettier" },
        jsonc = { "prettier" },
        json5 = { "prettier" },
        
        -- Стили, разметка и другие конфиги
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
}
