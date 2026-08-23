return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp", -- Оставляем только чистый HTML сервер
        "css-lsp",
      },
    },
  },
}
