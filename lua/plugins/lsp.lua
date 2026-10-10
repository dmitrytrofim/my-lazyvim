return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              suggest = {
                -- Включаем автоматический импорт при автодополнении
                autoImports = true,
              },
              preferences = {
                -- Говорим LSP предпочитать алиасы из tsconfig (non-relative), 
                -- а не строить длинные относительные пути вида ../../../../components
                importModuleSpecifier = "non-relative",
                importModuleSpecifierPreference = "project-relative",
              },
            },
            javascript = {
              suggest = { autoImports = true },
              preferences = {
                importModuleSpecifier = "non-relative",
                importModuleSpecifierPreference = "project-relative",
              },
            },
          },
        },
      },
    },
  },
}
