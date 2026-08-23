return {
  {
    -- Обновили адрес репозитория на новый 👇
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "emmet-language-server", -- Ставим Emmet
      },
    },
  },
}
