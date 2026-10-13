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
          },
        },
      },
    },
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

      -- ИДЕАЛЬНЫЙ НАДЁЖНЫЙ OUTLINE (РАБОТАЕТ ЧЕРЕЗ ТРЕЕСИТТЕР В ЛЮБОМ ФАЙЛЕ)
      {
        "gO",
        function()
          -- Умный тогл: если окно структуры уже открыто, повторное нажатие gO его закроет
          for _, win in ipairs(vim.fn.getwininfo()) do
            if win.quickfix == 1 then
              vim.cmd("cclose")
              return
            end
          end

          local file = vim.fn.expand("%:p")
          if file == "" then return end

          -- СВЕРХМОЩНЫЙ РЕГУЛЯРНЫЙ ШАБЛОН ДЛЯ ВЕБ-РАЗРАБОТКИ:
          -- 1. ^\s*(const|let|var|function|class|interface|type|enum) — ловит любые объявления переменных, функций и TS-типов.
          -- 2. ^\s*export\s+(default\s+)? — ловит любые именованные и дефолтные экспорты (включая инлайн-экспорты).
          -- 3. ^\s*import\s+ — ловит импорты модулей, чтобы видеть зависимости файла.
          -- 4. ^\s*use[A-Z]\w+\( — ловит вызовы хуков React/Next (например, useEffect, useTranslations), даже если они без const.
          -- 5. ^\s*\<[A-Za-z]+ — ловит любые HTML и JSX теги разметки (<div, <section, <NextImage).
          -- 6. ^\s*(\.|\&|\#|\@) — ловит в SCSS: классы (.), амперсанды (&), айдишники (#) и миксины/директивы (@media, @import).
          local regex = [[\v^\s*(const|let|var|function|class|interface|type|enum)>|^\s*export>|^\s*import>|^\s*use[A-Z]\w+\(|^\s*\<[A-Za-z]+|^\s*(\.|\&|\#|\@)]]

          -- Запускаем нативный Си-поиск Neovim
          vim.cmd("silent! vimgrep /" .. regex .. "/j " .. vim.fn.fnameescape(file))

          -- Открываем Quickfix горизонтальной панелью снизу высотой в 12 строк
          vim.cmd("botright copen 12")

          -- БЕЗОПАСНАЯ НАСТРОЙКА КЛАВИШ НАВИГАЦИИ (O и L)
          -- Добавляем автоматическое центрирование (zz), чтобы строка кода всегда была по центру экрана!
          pcall(vim.keymap.set, "n", "o", "<CR>zz<C-w>p", { buffer = 0, silent = true })
          pcall(vim.keymap.set, "n", "l", "<CR>zz<C-w>p", { buffer = 0, silent = true })

          -- НАМЕРТВО СКРЫВАЕМ ПЕРВЫЕ ДВУХ КОЛОКОК (Путь и колонки полностью прозрачны)
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nvic"

          -- Нативное визуальное скрытие имени файла и номеров колонок до разделителя "|"
          vim.fn.matchadd("Conceal", [[^[^|]*|]])
          vim.fn.matchadd("Conceal", [[[^|]*|]])
        end,
        desc = "Document Outline (TSX & SCSS All Cases)",
      },
    },
  },
}
