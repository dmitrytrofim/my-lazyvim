return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Меняем стандартный внешний вид окон Hover во всем Neovim
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          -- Делаем аккуратную тонкую рамку вместо жирных блоков
          border = "rounded",
          -- Автоматически фокусироваться на окне при повторном нажатии F1
          focusable = true,
        }
      )
    end,
  },
}
