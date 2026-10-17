return {
  -- 1. Бан для старого аутлайна
  { "hedyhli/outline.nvim", enabled = false },

  -- 2. Наша чистая конфигурация Snacks
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = {
        enabled = true,
        animate = { enabled = false },
        indent = { enabled = false },   
        scope = {
          enabled = true,
          char = "│",
          animate = {
            enabled = true,
            duration = 0,
          },
        },
      },
      scope = { enabled = true },
      explorer = { replace_netrw = true },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "focus_list", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["o"] = "confirm",
            },
          },
        },
        sources = {
          explorer = {
            hidden = true,
            focus = "list",
            auto_close = true,
            jump = { close = true },
            cwd = true,
            layout = {
              preset = "sidebar",
            },
            win = {
              list = {
                keys = {
                  -- Обе стрелки вызывают confirm строго внутри проводника проекта
                  ["<Right>"] = "confirm",
                  ["<Left>"] = "confirm",
                },
              },
            },
          },
        },
      },
    }, -- Здесь теперь всё закрыто корректно, без синтаксического мусора
    keys = {
      {
        "<leader>fe",
        function()
          if Snacks and Snacks.picker and Snacks.picker.explorer then
            Snacks.picker.explorer({ enter = true })
          end
        end,
        desc = "Explorer",
      },
      { 
        "<leader>ff", 
        function() Snacks.picker.files() end, 
        desc = "Find Files (Project Root)" 
      },
      { 
        "<leader>fF", 
        function() 
          Snacks.picker.files({ 
            cwd = vim.fn.expand("%:p:h"),
            title = "Files in Current Dir",
          }) 
        end, 
        desc = "Find Files (Current Directory)" 
      },

    -- ИДЕАЛЬНЫЙ НАВИГАТОР: Вытягивает структуру через Tree-sitter
      {
        "gO",
        function()
          if Snacks and Snacks.picker and Snacks.picker.lsp_symbols then
            Snacks.picker.lsp_symbols({
              layout = {
                preset = "sidebar",
                side = "right",
              },
              -- МАГИЯ ЗДЕСЬ: переключаем источник с LSP на Tree-sitter!
              -- Это заставит панель мгновенно читать структуру файла, даже если LSP завис
              backend = "treesitter",
            })
          end
        end,
        desc = "Structure Outline (Tree-sitter Backend)",
      },
    }
  },
}
