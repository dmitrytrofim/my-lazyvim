return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- Назначаем форматировщики для конкретных языков
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      -- Настройка автосохранения
      format_on_save = {
        -- Если форматировщик зависнет, Neovim не зафризит, а просто пропустит его через 500мс
        timeout_ms = 500,
        lsp_fallback = true, -- Если prettier нет в проекте, использовать правила самого LSP
      },
    },
  },
}
